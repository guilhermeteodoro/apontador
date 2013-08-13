Checker::Application.routes.draw do
  # resources :users
  match 'manager/employee/new'            => 'users#new', via: :get, as: 'new_user'
  match 'manager/employee'                => 'users#create', via: :post, as: 'users'
  match 'manager/employee/:username'      => 'users#show', via: :get, as: 'user'
  match 'manager/employee/:username'      => 'users#update', via: :put, as: 'user'
  match 'manager/employee/:username/edit' => 'users#edit', via: :get, as: 'edit_user'


  match 'manager' => 'manager/users#create', via: :post, as: 'manager_users'
  match 'manager' => 'manager/users#index', via: :get, as: 'manager_users'
  match 'signup'  => 'manager/users#new', as: 'signup'

  match 'checking'  => 'checkings#create', via: :post, as: 'create_checking'
  match 'checking'  => 'checkings#new', via: :get
  match 'checking'  => 'checkings#update', via: :put, as: 'update_checking'

  match 'manager/company' => 'companies#create', via: :post, as: 'companies'
  match 'manager/company' => 'companies#new', as: 'new_company'

  match 'login'  => 'login#login', as: 'login'
  match 'logout' => 'login#logout', as: 'logout'

  match '/' => 'login#redirecter'
  root to: 'login#redirecter'
end
