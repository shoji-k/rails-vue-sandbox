Rails.application.routes.draw do
  root to: 'static#index'

  namespace :api, format: 'json' do
    namespace :v1 do
      post 'sign_in' => 'user_token#create'
      resources :users
      resources :todos
    end
  end
end
