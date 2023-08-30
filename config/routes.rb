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
  root :to => 'sessions#new'
  post 'login' => "sessions#create", as: :login, constraints: NotLoggedIn.new
  get 'login' => "sessions#create", constraints: NotLoggedIn.new
  constraints(IsLoggedIn.new) do
    resources :invitation, only: [:update, :index]
    resource :confirm, only: [:show, :create]
    resource :about, only: [:show]
    post 'reset' => "sessions#destroy", as: :reset
  end

  match "*path" => redirect("/"), via: [:get, :post]
end
