class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  # after_initialize :ensure_session_token

  has_many :cat_rental_requests,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :user

  has_many :cats,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Cat

  has_many :sessions,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Session

  attr_reader :password

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    return user if user && BCrypt::Password.new(user.password_digest)
        .is_password?(password)
    nil
  end

  def generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  # # TODO: Update
  # def ensure_session_token
  #   self.session_token ||= generate_session_token
  # end
  #
  # def reset_session_token!
  #   self.session_token = SecureRandom::urlsafe_base64(16)
  #   save!
  #   self.session_token
  # end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  # For multiple logins
  # Chck if sesion[session_token] exists in user
    # If do nothing
  # Add new session token to sessions (allow log and signup)
  # Destroy
    # Destroy the sesion token passed

  def ensure_session_token2

  end

end
