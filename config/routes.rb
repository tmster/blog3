Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  get 'welcome/index'

  resources :articles do
    get 'toggle_visibility', on: :member
    resources :comments do
      resources :rates
    end
    resources :likes, only: %i[create destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
