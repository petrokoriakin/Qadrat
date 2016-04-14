class Post < ActiveRecord::Base
  has_attached_file :image, styles: { large: "600x600>", medium: "350x350>", thumb: "150x150#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  validates :title, presence: true, length: { minimum: 5, maximum: 60 }
  validates :body, presence: true
  validates :tags, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
    joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
      # Tag.find_or_create_by_name(n.strip)
    end
  end

  def titleValid
    return title if title.size < 28
    tester = ''
    result = ''
    arr = title.split(' ')

    arr.each do |item|
      tester += item + ' '
      if tester.size + 3 < 28
        result = tester
      else
        result += '...'
        return result
      end
    end
  end

end
