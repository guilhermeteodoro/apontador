Checker::Application.routes.draw do

  controller :users do
    get     "manager/employee/new"            => "users#new", as: "new_user"
    post    "manager/employee"                => "users#create", as: "users"
    get     "manager/employee/:username"      => "users#show", as: "user"
    put     "manager/employee/:username"      => "users#update", as: "user"
    delete  "manager/employee/:username"      => "users#destroy", as: "user"
    get     "manager/employee/:username/edit" => "users#edit", as: "edit_user"
  end

  controller "manager::users" do
    get     "manager"       => "manager/users#index", as: "manager_users"
    get     "signup"        => "manager/users#new", as: "signup"
    post    "manager"       => "manager/users#create", as: "manager_users"
    put     "manager"       => "manager/users#update", as: "manager_user"
    delete  "manager"       => "manager/users#destroy", as: "manager_user"
    get     "manager/edit"  => "manager/users#edit", as: "edit_manager_user"
  end

  controller :checkings do
    post  "check-in"    => "checkings#create", as: "checkings"
    get   "check-in"    => "checkings#new", as: "check_in"
    get   "check-out"   => "checkings#edit", as: "check_out"
    put   "check-out"   => "checkings#update", as: "checking"
  end

  controller :users do
    get "edit"    => "users#edit", as: "edit_employee_user"
    put "edit"    => "users#update", as: "edit_employee_user"
    get "report"  => "users#report", as: "report_employee"
  end

  controller :companies do
    get     "manager/company/new" => "companies#new", as: "new_company"
    post    "manager/company"     => "companies#create", as: "company"
    put     "manager/company"     => "companies#update", as: "company"
    delete  "manager/company"     => "companies#destroy", as: "company"
  end

  controller :tasks do
    put   "manager/tasks/:id"     => "tasks#update", as: "task"
    get   "manager/tasks/:id"     => "tasks#show", as: "tasks"
    get   "manager/task/new"      => "tasks#new", as: "new_task"
    post  "manager/task/new"      => "tasks#create", as: "task"
    get   "manager/task/edit/:id" => "tasks#edit", as: "edit_task"

    get "no-task"             => "tasks#no_task", as: "no_task"
    get "task-in-negotiation" => "tasks#task_in_negotiation", as: "task_in_negotiation"
  end

  controller :sessions do
    match "login"  => "sessions#login", as: "login"
    get   "logout" => "sessions#logout", as: "logout"
  end

  controller :public do
    get "index" => "public#index"
  end

  root to: "public#redirecter"

end