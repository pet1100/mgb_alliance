class NotLoggedIn
  def matches?(request)
    !request.session[:user_id]
  end
end

class IsLoggedIn
  def matches?(request)
    request.session[:user_id]
  end
end

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root :to => 'sessions#new', constraints: NotLoggedIn.new
  post 'login' => "sessions#create", as: :login, constraints: NotLoggedIn.new
  constraints(IsLoggedIn.new) do
    root :to => 'invitation#index', as: :home
    resource :confirm, only: [:show, :create]
    resource :about, only: [:show]
    post 'reset' => "session#destroy", as: :reset
  end
end
