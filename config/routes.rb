Rails.application.routes.draw do

  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
	root                  'users#show'
	
	post 'up/:id'				=>		'tasks#prioritizeUp', 		as: 'up'
	post 'down/:id'			=>		'tasks#prioritizeDown', 	as: 'down'
	delete 'logout'			=>		'users#destroy',					as: 'destroy'


	resources :projects,				only: [:create, :update, :destroy]
	resources :tasks,						only: [:create, :update, :destroy]
end
