Rails.application.routes.draw do
  get 'user_search/index'
  get 'user_search/show'
  resources :articles do
    collection do
      post :search
    end
  end
  devise_for :users

  root "articles#index"
end
