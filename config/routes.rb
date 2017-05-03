Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tasks
    resources :tasks do
      member do
        post :join
        post :quit
      end
      resources :resumes
    end
  root 'welcome#index'
  namespace :admin do
    resources :tasks do
      member do
        post :publish
        post :hide
      end
      resources :resumes
    end
  end
  namespace :account do
    resources :tasks
  end
end
