Rails.application.routes.draw do

  resources :interventions
  get "interventions", to: "interventions#new"

  resources :leads  
  devise_for :users

  # get "leads", to: "leads#new"
  # post "leads", to: "leads#create"
  # get "leads/index", to: "leads#index"
  
  post "/", to: "leads#create"
  get "quotes", to: "quotes#new"
  post "quotes", to: "quotes#create"

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
  get "commercial",  to: "home#commercial"
  get "residential", to: "home#residential"


  resources :synthesized_messages
  
end

Rails.application.routes.draw do

  get 'get_building_by_customer/:customer_id', to: 'interventions#get_building_by_customer'  

  get 'get_battery_by_building/:building_id', to: 'interventions#get_battery_by_building'
  
  get 'get_column_by_battery/:battery_id', to: 'interventions#get_column_by_battery'

  get 'get_elevator_by_column/:column_id', to: 'interventions#get_elevator_by_column'

 end