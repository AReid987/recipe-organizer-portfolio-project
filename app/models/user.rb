class User < ApplicationRecord
  has_secure_password
  has_many :recipes
  has_many :comments

  scope :most_recipes, -> { joins(:recipes).group('id').order('count(recipes.id) DESC').limit(1) }

  validates :name, presence: true
  validates :username, uniqueness: true, :allow_nil => true, :allow_blank => true

  def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name unless user.name != nil
    user.password = SecureRandom.urlsafe_base64 unless user.password != nil
    user.save!
    end
  end

end
