Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :users
      resources :todos
    end
  end
end
