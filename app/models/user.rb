class User < ApplicationRecord
  attr_accessor :remember_token

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, 
                    length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  before_create :remember

  def remember
    self.remember_token = SecureRandom.urlsafe_base64
    self.remember_digest = Digest::SHA1.hexdigest(remember_token.to_s)
  end
=begin
  def remember
    self.remember_token = SecureRandom.urlsafe_base64
    update_attribute(:remember_digest, Digest::SHA1.hexdigest(remember_token.to_s))
  end
=end
end
