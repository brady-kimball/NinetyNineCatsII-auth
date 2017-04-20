class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

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

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def show_logins
    sesh = Session.where(user_id: self.id)
    sesh.map(&:user_agent)
  end

end
