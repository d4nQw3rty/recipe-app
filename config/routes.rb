Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#public'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/recipes', to: 'recipes#index', as: 'recipes'
  get '/public_recipes', to: 'recipes#public', as: 'public_recipes'
  get '/recipes/new', to: 'recipes#new', as: 'recipe_new'
  post 'recipes', to: 'recipes#create', as: 'recipe_create'
  delete 'recipes/:id/delete', to: 'recipes#destroy', as: 'recipe_delete'
  get '/recipes/:id', to: 'recipes#show', as: 'recipe'
  get '/recipes/:recipe_id/new_ingredient', to: 'recipe_foods#new', as: 'ingredient_new'
  post 'recipes/:recipe_id', to: 'recipe_foods#create', as: 'ingredient_create'
  delete 'recipes/:recipe_id/delete/:id', to: 'recipe_foods#destroy', as: 'ingredient_delete'
  post '/recipes/:id/toggle', to: 'recipes#toggle', as: 'recipe_toggle'
  resources :users, only: [:index, :show ]
  resources :foods, only: [:index, :create, :new,  :destroy]
end
