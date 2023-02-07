Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'recipes#index'
  get '/recipes', to: 'recipes#index', as: 'recipes'
  get '/public_recipes', to: 'recipes#public', as: 'public_recipes'
  get '/recipes/:id', to: 'recipes#show', as: 'recipe'
  post '/recipes/:id/toggle', to: 'recipes#toggle', as: 'recipe_toggle'
end
