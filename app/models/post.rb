class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  # dependent: :destroyをつけることで、投稿が削除されたら、いいねも削除する
  # orderは順序を指定する。descは降順でソートするという意味なので、新しいいいね順で取得できる。
  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :photos
  # accepts_nested_attributes_forは、親子関係のある関連モデル(今回でいうとPostモデルとPhotoモデル）で、親から子を作成したり保存するときに使える。

  def liked_by(current_user)
    Like.find_by(user_id: user.id, post_id: id)
    # user_idとpost_idが一致するlikeを検索する。
  end
end
