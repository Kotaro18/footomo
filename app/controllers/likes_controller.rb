class LikesController < ApplicationController

  before_action :authenticate_user!
  # サインイン済みユーザーのみに、アクセス許可を与えている。

  def create
    @like = current_user.likes.build(like_params)
    # buildメソッドを使って、インスタンスを作成する。
    @post = @like.post
    # postメソッドはgetメソッドと同じこと役割で、情報を取得する際に使う。
    # ここでは、@likeに紐づく、post_id(いいねを押した投稿のid)とuser_id(現在サインインしているユーザーのid)の情報を取得する。
    # @postは、どの投稿にいいねを押したかを判断するために、ビュー作成時に使用する。
    if @like.save
      respond_to :js
      # respond_toは、返却するレスポンスのフォーマットを切り替えるためのメソッド
      # 今回いいねを押したら、リアルタイムでビューを反映させるために、JS形式でレスポンスを返す様にしている。
    end
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    # 受け取ったHTTPリクエストから、idを判別し、指定のレコード1つを@likeに代入している。
    @post = @like.post
    if @like.destroy
      respond_to :js
    end
  end

  private
    def like_params
      params.permit(:post_id)
      # paramsは送られてきたリクエスト情報をひとまとめにする。
      # permitは変更を加えられるキーを指定する。今回の場合は、post_id
      # つまり、いいねを押した時に、どの投稿をいいねしたのかpost_id(キー)の情報(バリュー)を変更する。
    end
end
