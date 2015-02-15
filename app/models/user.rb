require 'bcrypt'

class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password

  after_initialize :ensure_session_token

  has_many :moderated_subs,
    class_name: "Sub",
    foreign_key: :mod_id,
    primary_key: :id,
    inverse_of: :moderator

  has_many :comments,
    class_name: "Comment",
    foreign_key: :author_id,
    primary_key: :id,
    dependent: :destroy

  has_many :posts, dependent: :destroy

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)

    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def password=(value)
    @password = value
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
