Rails.application.routes.draw do
  resources :articles do
    collection do
      post :search
    end
  end
  resources :user_search
  devise_for :users

  root "articles#index"
end
