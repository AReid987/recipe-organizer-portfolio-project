class User < ApplicationRecord
  has_secure_password
  has_many :recipes

  validates :name, presence: true
  validates :email, presence: true
  validates :username, uniqueness: true

  def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name unless user.name != nil
    user.email =  SecureRandom.hex + '@example.com' unless user.email != nil
    #user.activated = true
    user.password = SecureRandom.urlsafe_base64 unless user.password != nil
    user.save!
  end
end
end
