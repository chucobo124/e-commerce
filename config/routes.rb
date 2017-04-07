Rails.application.routes.draw do
  root 'homes#index', id: 1
  devise_for :users, controllers: { sessions: 'users/sessions',
                                    passwords: 'users/passwords',
                                    registrations: 'users/registrations' }
  resources :orders, only: [:create, :new, :index], on: :user
  namespace :admin do
    root 'homes#index'
    resources :variants, only: :index
    resources :orders
    resources :products do
      resources :variants, except: :index
    end
  end
end
