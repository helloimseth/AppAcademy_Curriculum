require 'bcrypt'

class User  < ActiveRecord::Base
  attr_reader :password

  validates :email, :password_digest, :session_token, presence: true

  after_initialize :ensure_session_token

  def self.find_by_credentials(em, pw)
    user = User.find_by(email: em)

    user.is_password?(pw) ? user : nil
  end

  def reset_session_token!
    self.session_token = make_new_token
    self.save!
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest) == password
  end

  private
    def ensure_session_token
      generate_session_token if self.session_token.nil?
    end

    def generate_session_token
      self.session_token ||= make_new_token
    end

    def make_new_token
      SecureRandom::urlsafe_base64
    end
end
