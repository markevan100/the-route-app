Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  get 'welcome/yourroute', to: 'welcome#yourroute'
  post 'welcome/index', to: 'welcome#post'

  get 'welcome/comments', to: 'welcome#comments'


end
