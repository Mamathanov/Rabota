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
  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: email_regex },uniqueness: { case_sensitive: false }


  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password
end
