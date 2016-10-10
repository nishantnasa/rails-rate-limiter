Rails.application.routes.draw do
  # get 'home/index'
  match ':controller(/:action(/:id))', :via => :get

  # You can have the root of your site routed with "root"
  root 'home#index'

end
