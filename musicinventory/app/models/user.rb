require 'bcrypt'

class User  < ActiveRecord::Base
  attr_reader :password

  validates :email, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 8, allow_nil: true }

  after_initialize :ensure_session_token,
                   :default_to_inactive

  has_many :notes

  def self.find_by_credentials(em, pw)
    user = User.find_by(email: em)

    return nil if user.nil?

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

  def inactive?
    activated == false
  end

  def generate_activation_token!
    self.activation_token = make_new_token
    self.save!
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

    def default_to_inactive
      self.activated = false
    end

end
