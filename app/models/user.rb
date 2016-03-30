class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_attached_file :avatar, styles: { medium: "300x300>", small: "260x260>" },
                    default_url: "missing_:style.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
