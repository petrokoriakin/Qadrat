class Tag < ActiveRecord::Base
  has_many :taggings # , dependent: :destroy
  has_many :posts, through: :taggings

   has_many :subscriptions
  has_many :subscribed_users, source: :user, through: :subscriptions
end
