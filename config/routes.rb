Rails.application.routes.draw do
  get 'home/index'
  get 'pokemons/index'
  root 'home#index'

  resources :pokemons do
    collection do
      get 'search', to: 'pokemons#search'  # Route for search action
    end
  end

  get "/pokemons/:id", to: "pokemons#show"
  get "up" => "rails/health#show", as: :rails_health_check
end
