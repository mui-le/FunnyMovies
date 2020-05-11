class Movie < ApplicationRecord
  URL_REGEXP = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
  validates :url, presence: true, format: { with: URL_REGEXP}, length: { maximum: 500 }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :description, presence: true

  default_scope -> { order(created_at: :desc) }

  belongs_to :user

  def youtube_id
    if self.url[/youtu\.be\/([^\?]*)/]
      $1
    else
      self.url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      $5
    end
  end
end
