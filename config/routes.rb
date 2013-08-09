Apontador::Application.routes.draw do

  match 'manager' => 'manager/users#index'
  match 'signup'  => 'manager/users#new'

  match 'manager/employee/new' => 'users#new', as: 'new_employee'

  match 'checking'  => 'checkings#create', via: :post, as: 'create_checking'
  match 'checking'  => 'checkings#new', via: :get
  match 'checking'  => 'checkings#update', via: :put, as: 'update_checking'

  match 'manager/company' => 'companies#create', via: :post, as: 'companies'
  match 'manager/company' => 'companies#new', as: 'new_company'

  match 'login'  => 'login#login'
  match 'logout' => 'login#logout'

  match '/' => 'login#redirecter'
  root to: 'login#redirecter'
end
