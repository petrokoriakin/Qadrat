class Post < ActiveRecord::Base
  has_attached_file :image, styles: { large: "600x600>", medium: "350x350>", thumb: "150x150#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true
end
