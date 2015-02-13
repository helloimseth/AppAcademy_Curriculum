require 'bcrypt'

class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}

  attr_reader :password

  after_initialize :ensure_session_token
  
  def password=(value)
    self.password_digest = BCrypt::Password.create(value)
  end

  def reset_session_token!
    self.session_token = make_token
    self.save!
  end

  def is_password?(attempt)
    BCrypt::Password.new(password_digest) == attempt
  end

  private

  def make_token
    token = SecureRandom::urlsafe_base64
    while User.where(session_token: token).any?
      token = SecureRandom::urlsafe_base64
    end
    token
  end

  def ensure_session_token
    self.session_token ||= make_token
  end

end
