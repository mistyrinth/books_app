Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  root to: 'books#index'

  resources :books do
    resources :comments
  end
  
  resources :reports do
    resources :comments
  end

  resources :users do
    member do
      get :follows, :followers, :timeline
    end
  end

  resources :relationships, only: [:create, :destroy]

  scope "(:locale)" do
    resources :users
  end

  # letter_opener_web
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
