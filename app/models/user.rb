class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :password, presence: true, on: :create, length: { minimum: 5 }

  def sluggable_attribute
    username
  end

  def admin?
    self.role == 'admin'
  end
end
