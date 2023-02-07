Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/recipes', to: 'recipes#index', as: 'recipes'
  get '/public_recipes', to: 'recipes#public', as: 'public_recipes'
end
