Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  resources :tasks do
    member do
      post :join
      post :quit
      post :publish
      post :hide
    end
    resources :resumes
  end
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
    resources :resumes
  end
end
