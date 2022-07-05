Rails.application.routes.draw do
  root 'users#index'

  get 'users/', to: 'users#index'
  post 'users/', to: 'users#create'
  get 'users/new', to: 'users#new'
  delete 'users/delete_all', to: 'users#delete_all'

  post 'comments/', to: 'comments#create'
end
