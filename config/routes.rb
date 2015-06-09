Rails.application.routes.draw do
	root                  'users#show'
	
	post 'up/:id'				=>		'tasks#prioritizeUp', 		as: 'up'
	post 'down/:id'			=>		'tasks#prioritizeDown', 	as: 'down'


	resources :projects,				only: [:create, :update, :destroy]
	resources :tasks,						only: [:create, :update, :destroy]
end
