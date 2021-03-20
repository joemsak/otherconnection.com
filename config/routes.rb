require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  namespace :user do
    resources :registrations
    resources :sessions, only: %i[new create]
    resource :dashboard, only: :show
  end

  get 'user/sessions/new', as: :signin
  get 'user/registrations/new', as: :signup

  root to: 'user/dashboards#show'
end
