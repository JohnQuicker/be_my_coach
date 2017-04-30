Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :jobs
  resources :tasks
  root 'tasks#index'
  namespace :admin do
    resources :tasks do
      member do
        post :publish
        post :hide
      end
    end
  end
end
