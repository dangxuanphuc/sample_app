class Micropost < ApplicationRecord
  belongs_to :user

  scope :desc, -> {order created_at: :desc}
  scope :feed, -> (following_ids, id){
    Micropost.where("user_id IN (?)
      OR user_id = (?)", following_ids, id)
  }

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost_max_length}

  private

  def picture_size
    if picture.size > Settings.picture_size.megabytes
      errors.add :picture, t(".picture_size")
    end
  end
end
