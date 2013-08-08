Apontador::Application.routes.draw do
  resource :users

  namespace :manager do
    resource :users
  end
  match 'manager'   => 'manager/users#index'
  match 'signup'    => 'manager/users#new'

  match 'checking'  => 'checkings#create', via: :post, as: 'create_checking'
  match 'checking'  => 'checkings#new', via: :get
  match 'checking'  => 'checkings#update', via: :put, as: 'update_checking'

  match 'new_company' => 'companies#new', via: :post
  match 'new_company' => 'companies#new'

  match 'login'     => 'login#login'
  match 'logout'    => 'login#logout'

  match '/'         => 'login#redirecter'
  root to: 'login#redirecter'
end
