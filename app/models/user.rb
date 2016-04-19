class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: [:slugged, :history, :finders]

  def should_generate_new_friendly_id?
    username_changed?
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { medium: "300x500>", small: "90x90>" }
                    # default_url: "missing_:style.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates :username, uniqueness: { case_sensitive: true,
    message: "User with this name already exists." }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :subscriptions, dependent: :destroy
  has_many :subscribed_tags, source: :tag, through: :subscriptions

  def follow(tag_id)
    subscriptions.create(tag_id: tag_id)
  end

  def unfollow(tag_id)
    subscriptions.find_by(tag_id: tag_id).destroy
  end

  def is_following(user_id, tag_id)
    is_sub = Subscription.find_by(user_id: user_id, tag_id: tag_id)
    if is_sub
      return true
    else
      return false
    end
  end

  def following_tag_list
    subscribed_tags.map(&:name)
  end

  def role?(requested_role)
    self.role == requested_role.to_s
  end
end
