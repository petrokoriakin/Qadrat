class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { medium: "300x500>", small: "90x90#" },
                    default_url: "missing_:style.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates :username, uniqueness: { case_sensitive: true, message: "User with this name already exists." }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :subscriptions, dependent: :destroy
  has_many :subscribed_tags, source: :tag, through: :subscriptions

  def follow (id_of_tag)
    subscriptions.create(tag_id: id_of_tag)
  end

  def unfollow (id_of_tag)
    subscriptions.find_by(tag_id: id_of_tag).destroy
  end

  def is_following(id_of_user, id_of_tag)
    is_sub = Subscription.find_by(user_id: id_of_user, tag_id: id_of_tag)
    if is_sub
      return true
    else
      return false
    end
  end

  def following_tag_list
    subscribed_tags.map(&:name)
   # subscribed_tags.map(&:id)
  end

  ROLES = %w[admin moderator user]

  def role?(requested_role)
    self.role == requested_role.to_s
  end
end
