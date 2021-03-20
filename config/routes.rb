require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  namespace :user do
    resources :registrations
    resource :session, only: %i[new create destroy]
    resource :dashboard, only: :show
  end

  get 'signup', to: 'user/registrations#new', as: :signup
  get 'signin', to: 'user/sessions#new', as: :signin
  delete 'signout', to: 'user/sessions#destroy', as: :signout
  get 'signout', to: 'user/sessions#destroy'

  root to: 'user/dashboards#show'
end
