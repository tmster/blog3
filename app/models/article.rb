class Article < ApplicationRecord
  mount_uploader :cover, ImageUploader

  validates :title, presence: true, length: { minimum: 5 }

  has_many :comments, dependent: :destroy
  belongs_to :author, class_name: 'User'

  has_many :likes
  has_many :users, through: :likes

  scope :published, -> { where(published: true) }
  scope :most_commented, -> { order(comments_count: :desc).first }

  def tags=(value)
    value = sanitize_tags(value) if value.is_a?(String)
    super(value)
  end

  def css_class
    if published?
      'normal'
    else
      'unpublished'
    end
  end

  private

  def sanitize_tags(text)
    text.downcase.split.uniq
  end
end
