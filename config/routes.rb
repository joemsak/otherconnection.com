require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  namespace :user do
    resources :registrations
  end

  get 'user/registrations/new', as: :signup

  root to: 'pages/home#show'
end
