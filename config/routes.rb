Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  resources :users
  get "/profile" => "users#profile"

  resources :groups do 
  	put "/toggle" => "groups#toggle"
  	resources :contacts
  end
end
