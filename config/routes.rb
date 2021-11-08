Rails.application.routes.draw do
  devise_for :users, # ここの行にカンマを追加
    controllers: { registrations: 'registrations' } # ここの行を追加

  root 'posts#index'
  # postsコントローラーのindexアクションを処理する。

  get '/users/:id', to: 'users#show', as: 'user'
  get '/search', to: 'searchs#search'

  resources :posts, only: %i(new create index show destroy) do
    # resourcesを追加するだけで、各ページへのルートが作成される。
    resources :photos, only: %i(create)

    resources :likes, only: %i(create destroy)
    resources :comments, only: %i(create destroy)
  end
  # photosをネスト(入れ子)にすることで、postsと親子関係を紐づけられる。
end
