Checker::Application.routes.draw do

  controller :users do
    match 'manager/employee/new'            => 'users#new', via: :get, as: 'new_user'
    match 'manager/employee'                => 'users#create', via: :post, as: 'users'
    match 'manager/employee/:username'      => 'users#show', via: :get, as: 'user'
    match 'manager/employee/:username'      => 'users#update', via: :put, as: 'user'
    match 'manager/employee/:username'      => 'users#destroy', via: :delete, as: 'user'
    match 'manager/employee/:username/edit' => 'users#edit', via: :get, as: 'edit_user'
  end

  controller "manager::users" do
    match 'manager'       => 'manager/users#index', via: :get, as: 'manager_users'
    match 'signup'        => 'manager/users#new', as: 'signup'
    match 'manager'       => 'manager/users#create', via: :post, as: 'manager_users'
    match 'manager'       => 'manager/users#update', via: :put, as: 'manager_user'
    match 'manager'       => 'manager/users#destroy', via: :delete, as: 'manager_user'
    match 'manager/edit'  => 'manager/users#edit', via: :get, as: 'edit_manager_user'
  end

  controller :checkings do
    match 'check-in'    => 'checkings#create', via: :post, as: 'checkings'
    match 'check-in'    => 'checkings#new', via: :get, as: 'check_in'
    match 'check-out'   => 'checkings#edit', via: :get, as: 'check_out'
    match 'check-out'   => 'checkings#update', via: :put, as: 'checking'
  end

  controller :users do
    match 'edit'    => 'users#edit', via: :get, as: 'edit_employee_user'
    match 'edit'    => 'users#update', via: :put, as: 'edit_employee_user'
    match 'report'  => 'users#report', via: :get, as: 'report_employee'
  end

  controller :companiers do
    match 'manager/company/new' => 'companies#new', as: 'new_company'
    match 'manager/company'     => 'companies#create', via: :post, as: 'company'
    match 'manager/company'     => 'companies#update', via: :put, as: 'company'
    match 'manager/company'     => 'companies#destroy', via: :delete, as: 'company'
  end

  controller :tasks do
    match 'no-task'             => 'tasks#no_task', as: 'no_task'
    match 'task-in-negotiation' => 'tasks#task_in_negotiation', as: 'task_in_negotiation'
  end

  controller :tasks do
    match 'manager/task/new'      => 'tasks#new', via: :get, as: 'new_task'
    match 'manager/task'          => 'tasks#create', via: :post, as: 'task'
    # match 'manager/task/:id'      => 'tasks#index', via: :get, as: 'task'
    match 'manager/task/:id'      => 'tasks#update', via: :put, as: 'task'
    match 'manager/task/edit/:id' => 'tasks#edit', as: 'edit_task'
  end

  controller :sessions do
    match 'login'  => 'sessions#login', as: 'login'
    match 'logout' => 'sessions#logout', as: 'logout'
  end

  controller :public do
    match 'index' => 'public#index'
  end

  match '/' => 'public#redirecter'
  root to: 'public#redirecter'

end