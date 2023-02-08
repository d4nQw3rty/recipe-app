Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/recipes', to: 'recipes#index', as: 'recipes'
  get '/public_recipes', to: 'recipes#public', as: 'public_recipes'
  get '/recipes/new', to: 'recipes#new', as: 'recipe_new'
  delete 'recipes/:id/delete', to: 'recipes#destroy', as: 'recipe_delete'
  get '/recipes/:id', to: 'recipes#show', as: 'recipe'
  post 'recipes', to: 'recipes#create', as: 'recipe_create'
  post '/recipes/:id/toggle', to: 'recipes#toggle', as: 'recipe_toggle'
  resources :users, only: [:index, :show ]
end
