Checker::Application.routes.draw do
  resources :users
  match 'manager/employee/new'      => 'users#new', as: 'new_user'
  match 'manager/employee/:id/edit' => 'users#edit', as: 'edit_user'
  match 'manager/employee/:id'      => 'users#show', as: 'user'

  namespace :manager do
    resources :users
  end

  match 'manager' => 'manager/users#create', via: :post, as: 'manager_users'
  match 'manager' => 'manager/users#index', via: :get, as: 'manager_users'
  match 'signup'  => 'manager/users#new', as: 'signup'


  # match 'manager/employee/new'      => 'users#create', via: :post, as: 'employee'
  # match 'manager/employee/new'      => 'users#new', as: 'new_employee'
  # match 'manager/employee/:id/edit' => 'users#edit', as: 'edit_employee'
  # match 'manager/employee/:id'      => 'users#update', via: :put, as: 'employee'

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
