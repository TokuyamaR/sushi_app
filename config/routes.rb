Rails.application.routes.draw do
  root 'home#top'
  get "posts/top" => "posts#top", as: "post_top"
  devise_for :users
  resources :users
  resources :posts do
  	resources :post_comments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
