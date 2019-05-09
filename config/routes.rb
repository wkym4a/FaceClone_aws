Rails.application.routes.draw do
  #get 'sessions/new'
  resources :sessions, only: [:new, :create, :destroy]

  root 'tops#index'

  resources :users

  resources :pictures do
    collection do
      #【新規登録前のデータ確認用画面】へのルートを追加
      post :confirm
    end

    member do
      #【更新前のデータ確認用画面】へのルートを追加
      post :edit_confirm

      #【ユーザーごとのインデックス画面】へのルートを追加
      get :user_index
    end
  end
end
