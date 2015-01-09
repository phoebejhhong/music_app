class User < ActiveRecord::Base
  attr_reader :password

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password_digest, :session_token, presence: true
  before_validation :ensure_session_token

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(pass)
    BCrypt::Password.new(password_digest) == pass
  end

  def reset_session_token
    self.session_token = generate_session_token
  end

  def generate_session_token
    SecureRandom.urlsafe_base64
  end
  private
  def ensure_session_token
    self.session_token ||= generate_session_token
  end

end
