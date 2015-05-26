class User < ActiveRecord::Base
  email_regex = %r{
      ^
      [0-9a-z]
      [0-9a-z.+]+
      [0-9a-z]
      @
      [0-9a-z]
      [0-9a-z.-]+
      [0-9a-z]
      $
    }xi
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }

  validates :email, presence: true, length: { maximum: 255 },
            format: { with: email_regex},
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  has_secure_password
end
