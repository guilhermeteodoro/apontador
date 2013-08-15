Checker::Application.routes.draw do
  match 'manager/employee/new'            => 'users#new', via: :get, as: 'new_user'
  match 'manager/employee'                => 'users#create', via: :post, as: 'users'
  match 'manager/employee/:username'      => 'users#show', via: :get, as: 'user'
  match 'manager/employee/:username'      => 'users#update', via: :put, as: 'user'
  match 'manager/employee/:username'      => 'users#destroy', via: :delete, as: 'user'
  match 'manager/employee/:username/edit' => 'users#edit', via: :get, as: 'edit_user'

  match 'manager'       => 'manager/users#index', via: :get, as: 'manager_users'
  match 'signup'        => 'manager/users#new', as: 'signup'
  match 'manager'       => 'manager/users#create', via: :post, as: 'manager_users'
  match 'manager'       => 'manager/users#update', via: :put, as: 'manager_user'
  match 'manager'       => 'manager/users#destroy', via: :delete, as: 'manager_user'
  match 'manager/edit'  => 'manager/users#edit', via: :get, as: 'edit_manager_user'

  match 'check-in'  => 'checkings#create', via: :post, as: 'checkings'
  match 'check-in'  => 'checkings#new', via: :get, as: 'check_in'
  match 'check-out'  => 'checkings#edit', via: :get, as: 'check_out'
  match 'check-out'  => 'checkings#update', via: :put, as: 'checking'

  match 'manager/company/new' => 'companies#new', as: 'new_company'
  match 'manager/company' => 'companies#create', via: :post, as: 'company'
  match 'manager/company' => 'companies#update', via: :put, as: 'company'
  match 'manager/company' => 'companies#destroy', via: :delete, as: 'company'

  match 'login'  => 'login#login', as: 'login'
  match 'logout' => 'login#logout', as: 'logout'

  match '/' => 'login#redirecter'
  root to: 'login#redirecter'
end
