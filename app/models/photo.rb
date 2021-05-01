class Photo < ApplicationRecord
  belongs_to :post

  validates :image, presence: true
  # presence: trueは値が空でないことを確認する。

  mount_uploader :image, ImageUploader
  # imageカラムとImageUploader(app/uploaders/image_uploader.rbのクラスの名前)を紐付け。
end
