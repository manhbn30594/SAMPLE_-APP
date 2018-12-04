Rails.application.routes.draw do
  get "sessions/new"
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "static_pages/home"
    get "/help", to: "static_pages#help", as: "helf"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "/signup", to: "users#new"
    get "static_pages/help"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new", as: "li"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
end
end
