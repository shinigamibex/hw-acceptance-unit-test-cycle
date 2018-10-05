Rottenpotatoes::Application.routes.draw do
  #root 'movies#index'
  resources :movies do
  collection do
    get :similar_movie
  end
end
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end
