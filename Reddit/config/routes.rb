Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do 
    resources :subs, only: [:create] #get the users params & user_i. only want nested oor wild card
  end
  resource :session, only:[:new, :create, :destroy]
  resources :subs, only:[:new, :show, :update, :edit, :index, :destroy]
end
