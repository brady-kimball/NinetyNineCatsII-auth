class User < ActiveRecord::Base
  validates :session_token, presence: true, uniqueness: true
  validates :user_name, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  after_initialize :reset_session_token

  attr_reader :password

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    return user if user && BCrypt::Password.new(user.password_digest)
      .is_password?(password)
    nil
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64(16)
    save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

end
