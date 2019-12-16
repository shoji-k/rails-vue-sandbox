Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      post 'sign_in' => 'user_token#create'
      resources :users
      resources :todos
    end
  end
end
