class PostsController < ApplicationController
  before_action :authenticate_user!
  # before_actionはアクションを実行する前にフィルターをかけるメソッド
  # 今回は、postsコントローラーのnewアクションやcreateアクションを実行する前にauthenticate_user!を読み込む。
  # これで、サインインしていない状態でnewアクションやcreateアクションを実行しようとすると、サインインページにリダイレクトできる。

  before_action :set_post, only: %i(show destroy)

  def new
    @post = Post.new
    # newはインスタンスを作成するメソッド。引数がなければ空のインスタンスが作成される。
    @post.photos.build
    # buildもインスタンスを作成するメソッド。モデル(今回はpostとphoto)を関連付けするときに使う。
  end

  def create
    @post = Post.new(post_params)
    if @post.photos.present?
      @post.save
      redirect_to root_path
      flash[:notice] = "投稿が保存されました"
    else
      redirect_to root_path
      flash[:alert] = "投稿に失敗しました"
    end
  end

  def index
    @posts = Post.limit(10).includes(:photos, :user).order('created_at DESC')
    # limitメソッドは取り出すレコード数の上限を指定する。今回は、10個までの投稿を表示する。
    # orderはデータベースから取り出すレコードを特定の順序で並べたい場合に使用する。
    # order('created_at DESC')とすることで、created_atの降順、つまり投稿された最新の日時順に並び替える。
    # includesメソッドを使うと、関連するテーブルをまとめて取得できる。テーブル取得のN+1問題を解決できる。
  end
  
  def show
  end

  def destroy
    if @post.user == current_user
      flash[:notice] = "投稿が削除されました" if @post.destroy
    else
      flash[:alert] = "投稿の削除に失敗しました"
    end
    redirect_to root_path
  end

  private
  # privateではレシーバを指定できない。通常はレシーバにメソッドを合わせて使用するができない。つまり外部から呼び出せない。
    def post_params
      params.require(:post).permit(:caption, photos_attributes: [:image]).merge(user_id: current_user.id)
      # requireメソッド：受け取る値のキーを設定する。
      # permitメソッド：変更を加えられるキーを指定する。今回はcaptionとimage。
      # mergeメソッド：2つのハッシュを統合する。今回は誰が投稿したか情報が必要なため、user_idを統合する。
    end
    
    def set_post
      @post = Post.find_by(id: params[:id])
    # id及びid以外の条件が分かっている場合、その条件に該当する最初のデータを取得できる
    end
end
