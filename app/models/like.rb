class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }
  # uniquenessは重複していないことを検証する。
  # ここでは、user_idとpost_idが重複していないことを検証する。
end
