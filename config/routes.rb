Rails.application.routes.draw do
	root 'posts#index'
	get '/about', to: 'static_pages#about'
	get '/login',	to: 'sessions#new'
	post '/login',  to: 'sessions#update'
	delete '/logout', to: 'sessions#destroy'
	resources :posts, only: [:new, :create, :index]
end
