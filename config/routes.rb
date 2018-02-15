Rails.application.routes.draw do
  root "urls#index"
  resources :urls, only: [:new, :create, :index]

  get "/u/:path", to: "urls#visit"
end
