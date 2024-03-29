class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  # has_manyは他のモデルとの間に「1対多」のつながりを示す。
  # dependent: :destroyをつけることで、ユーザーが削除されると紐づく投稿も削除される。

  has_many :likes
  has_many :comments

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 50 }
  validates :username, uniqueness: true

  def update_without_current_password(params, *options)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end

