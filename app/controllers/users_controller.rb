class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    # find_byは与えられた条件にマッチする最初のレコードだけを返す。
    # paramsは送られてきたリクエスト情報をひとまとめに取得できる。
    # @があるとインスタンス変数になり、コントローラーからビューへ変数を渡すことができる。
  end
end
