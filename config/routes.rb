Sacobs::Application.routes.draw do

  devise_for :users

  resources :cities

  resources :trips

  resource :contacts, only: [:new, :create]

  resources :drivers

  resources :routes, only: [:index, :show, :destroy] do
   resources :builder, only: [:show, :update, :create],controller: 'routes/builder'
  end

  resources :buses, only: [:index, :show, :destroy] do
    resources :builder, only: [:show, :update, :create],controller: 'buses/builder'
  end

  root to: 'high_voltage/pages#show', id: 'home'

  match '(errors)/:status', to: 'errors#show', constraints: {status: /\d{3}/}, via: :all

end
#== Route Map
# Generated on 14 Oct 2013 16:32
#
#         new_user_session GET    /users/sign_in(.:format)                devise/sessions#new
#             user_session POST   /users/sign_in(.:format)                devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)               devise/sessions#destroy
#            user_password POST   /users/password(.:format)               devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)           devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)          devise/passwords#edit
#                          PATCH  /users/password(.:format)               devise/passwords#update
#                          PUT    /users/password(.:format)               devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)                 devise/registrations#cancel
#        user_registration POST   /users(.:format)                        devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)                devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)                   devise/registrations#edit
#                          PATCH  /users(.:format)                        devise/registrations#update
#                          PUT    /users(.:format)                        devise/registrations#update
#                          DELETE /users(.:format)                        devise/registrations#destroy
#                   cities GET    /cities(.:format)                       cities#index
#                          POST   /cities(.:format)                       cities#create
#                 new_city GET    /cities/new(.:format)                   cities#new
#                edit_city GET    /cities/:id/edit(.:format)              cities#edit
#                     city GET    /cities/:id(.:format)                   cities#show
#                          PATCH  /cities/:id(.:format)                   cities#update
#                          PUT    /cities/:id(.:format)                   cities#update
#                          DELETE /cities/:id(.:format)                   cities#destroy
#                    trips GET    /trips(.:format)                        trips#index
#                          POST   /trips(.:format)                        trips#create
#                 new_trip GET    /trips/new(.:format)                    trips#new
#                edit_trip GET    /trips/:id/edit(.:format)               trips#edit
#                     trip GET    /trips/:id(.:format)                    trips#show
#                          PATCH  /trips/:id(.:format)                    trips#update
#                          PUT    /trips/:id(.:format)                    trips#update
#                          DELETE /trips/:id(.:format)                    trips#destroy
#                 contacts POST   /contacts(.:format)                     contacts#create
#             new_contacts GET    /contacts/new(.:format)                 contacts#new
#                  drivers GET    /drivers(.:format)                      drivers#index
#                          POST   /drivers(.:format)                      drivers#create
#               new_driver GET    /drivers/new(.:format)                  drivers#new
#              edit_driver GET    /drivers/:id/edit(.:format)             drivers#edit
#                   driver GET    /drivers/:id(.:format)                  drivers#show
#                          PATCH  /drivers/:id(.:format)                  drivers#update
#                          PUT    /drivers/:id(.:format)                  drivers#update
#                          DELETE /drivers/:id(.:format)                  drivers#destroy
#      route_builder_index POST   /routes/:route_id/builder(.:format)     routes/builder#create
#            route_builder GET    /routes/:route_id/builder/:id(.:format) routes/builder#show
#                          PATCH  /routes/:route_id/builder/:id(.:format) routes/builder#update
#                          PUT    /routes/:route_id/builder/:id(.:format) routes/builder#update
#                   routes GET    /routes(.:format)                       routes#index
#                    route GET    /routes/:id(.:format)                   routes#show
#                          DELETE /routes/:id(.:format)                   routes#destroy
#        bus_builder_index POST   /buses/:bus_id/builder(.:format)        buses/builder#create
#              bus_builder GET    /buses/:bus_id/builder/:id(.:format)    buses/builder#show
#                          PATCH  /buses/:bus_id/builder/:id(.:format)    buses/builder#update
#                          PUT    /buses/:bus_id/builder/:id(.:format)    buses/builder#update
#                    buses GET    /buses(.:format)                        buses#index
#                      bus GET    /buses/:id(.:format)                    buses#show
#                          DELETE /buses/:id(.:format)                    buses#destroy
#                     root GET    /                                       high_voltage/pages#show {:id=>"home"}
#                                 (/errors)/:status(.:format)             errors#show {:status=>/\d{3}/}
#                     page GET    /*id                                    high_voltage/pages#show
