Rails.application.routes.draw do
  root "urls#index"
  resources :urls, only: [:new, :create, :index, :destroy]

  get "/u/:path", to: "urls#visit"
end
