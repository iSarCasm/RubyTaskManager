Rails.application.routes.draw do
	root                  'users#show'
	
	resources :projects,				only: [:create, :update, :destroy]
	resources :tasks,						only: [:create, :update, :destroy]
end
