Rails.application.routes.draw do
  get 'home/index'
  get 'pokemons/index'
  root 'home#index'
  resources :pokemons
  get "/pokemons/:id", to: "pokemons#show"
  get "up" => "rails/health#show", as: :rails_health_check
end
