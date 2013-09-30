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

  controller "manager::tasks" do
    put   "manager/tasks/:id"     => "manager/tasks#update", as: "manager_task_update"
    get   "manager/tasks/:id"     => "manager/tasks#show", as: "tasks"
    get   "manager/task/new"      => "manager/tasks#new", as: "new_task"
    post  "manager/task/new"      => "manager/tasks#create", as: "task"
    get   "manager/task/:id/edit" => "manager/tasks#edit", as: "manager_edit_task"
    # put   "manager/tasks/:id/accept"      => "manager/tasks#accept", as: "manager_task_accept"
    # put   "manager/tasks/:id/renegotiate" => "manager/tasks#renegotiate", as: "manager_task_renegotiate"
  end

  controller :tasks do
    get "redirecter"          => "tasks#redirecter", as: "tasks_redirecter"
    get "no-task"             => "tasks#no_task", as: "no_task"
    get "task-in-negotiation" => "tasks#edit", as: "edit_task"
    put "task-in-negotiation/:id" => "tasks#update", as: "task_update"
    put "task-in-negotiation/refuse/:id" => "tasks#refuse", as: "refuse_task"
    get "waiting-confirmation" => "tasks#waiting", as: "waiting"

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