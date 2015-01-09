class User < ActiveRecord::Base
  attr_reader :password

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password_digest, :session_token, presence: true
  validates :activated, inclusion: { in: [true, false] }
  before_validation :ensure_session_token, :ensure_not_admin,
                  :ensure_activation_token, :ensure_unactivated

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

  def ensure_not_admin
    self.admin = false if self.admin.nil?
  end

  def ensure_activation_token
    self.activation_token = SecureRandom.urlsafe_base64
  end

  def ensure_unactivated
    self.activated = false if self.activated.nil?
  end

end
