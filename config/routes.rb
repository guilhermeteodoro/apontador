Apontador::Application.routes.draw do
  resource :user
  match "home"    => "users#index"

  namespace :manager do
    resource :users
  end
  match "manager" => "manager/users#index"

  match "login"   => "login#login"
  match "logout"  => "login#logout"

  root to: "login#login"
end
