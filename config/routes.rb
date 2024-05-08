Rapidfire::Engine.routes.draw do
  draw :surveys
  # resources :surveys do
  #   get 'results', on: :member
  #
  #   resources :questions
  #   resources :attempts, only: [:new, :create, :edit, :update, :show]
  # end
  #
  # root :to => "surveys#index"
end

# Rapidfire::UserEngine.routes = Rapidfire::Engine.routes
Rapidfire::UserEngine.routes.draw_paths = Rapidfire::Engine.routes.draw_paths
Rapidfire::UserEngine.routes.draw do
  draw :surveys
end

Rapidfire::AdminEngine.routes.draw_paths = Rapidfire::Engine.routes.draw_paths
Rapidfire::AdminEngine.routes.draw do
  draw :surveys
end
