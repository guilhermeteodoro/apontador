Apontador::Application.routes.draw do
  match "home"    => "users#index"
  match "login"   => "login#login"
  match "logout"  => "login#logout"

  match "/"       => "login#adm", constraints: { subdomain: /.+/ }
  root to: "login#user"
end
