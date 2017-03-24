Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users, controllers: { sessions: 'users/sessions',
                                    passwords: 'users/passwords',
                                    registrations: 'users/registrations' }
  namespace :admin do
    resources :variants, only: :index
    root 'homes#index'
    resources :products do
      resources :variants, except: :index
    end
  end
end
