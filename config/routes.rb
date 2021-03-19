Rails.application.routes.draw do
  namespace :user do
    resources :registrations
  end

  get 'user/registrations/new', as: :signup

  root to: 'pages/home#show'
end
