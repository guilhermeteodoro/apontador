Apontador::Application.routes.draw do
  match "home"  => "people#index"
  match "login" => "login#login"

  root to: "login#login"
end
