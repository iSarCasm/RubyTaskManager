Rails.application.routes.draw do

  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
	root                  'users#show'
	get 'sql'						=>		'users#sql',							as: 'sql'
	post 'up/:id'				=>		'tasks#prioritizeUp', 		as: 'up'
	post 'down/:id'			=>		'tasks#prioritizeDown', 	as: 'down'
	delete 'logout'			=>		'users#destroy',					as: 'destroy'
	patch 'title/:id'		=>		'tasks#update_title',			as: 'update_title'
	patch 'deadline/:id'		=>		'tasks#update_deadline',			as: 'update_deadline'
	patch 'done/:id'		=>		'tasks#done',							as: 'done'
	resources :projects,				only: [:create, :update, :destroy]
	resources :tasks,						only: [:create, :destroy]
end
