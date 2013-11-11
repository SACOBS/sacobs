Sacobs::Application.routes.draw do


  namespace :availability do
    get :new
    post :check
  end


  devise_for :users

  resources :bookings, only: [:show, :index, :destroy] do
    member do
      patch :mark_as_paid
      patch :cancel
    end
    resources :builder, only: [:new, :create, :show, :update],controller: 'bookings/builder'
  end

  resources :clients

  resources :cities

  resource :contacts, only: [:new, :create]

  resources :drivers

  resources :trips, only: [:index, :show, :destroy] do
    member do
     post :copy
    end
    resources :builder, only: [:show, :update, :create, :destroy],controller: 'trips/builder'
  end

  resources :routes, only: [:index, :show, :destroy] do
   resources :builder, only: [:show, :update, :create, :destroy],controller: 'routes/builder'
  end

  resources :buses, only: [:index, :show, :destroy] do
    resources :builder, only: [:show, :update, :create, :destroy],controller: 'buses/builder'
  end

  root to: 'high_voltage/pages#show', id: 'home'

  match '(errors)/:status', to: 'errors#show', constraints: {status: /\d{3}/}, via: :all

end
#== Route Map
# Generated on 08 Nov 2013 15:10
#
#         availability_new GET    /availability/new(.:format)                 availability#new
#       availability_check POST   /availability/check(.:format)               availability#check
#         new_user_session GET    /users/sign_in(.:format)                    devise/sessions#new
#             user_session POST   /users/sign_in(.:format)                    devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)                   devise/sessions#destroy
#            user_password POST   /users/password(.:format)                   devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)               devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)              devise/passwords#edit
#                          PATCH  /users/password(.:format)                   devise/passwords#update
#                          PUT    /users/password(.:format)                   devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)                     devise/registrations#cancel
#        user_registration POST   /users(.:format)                            devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)                    devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)                       devise/registrations#edit
#                          PATCH  /users(.:format)                            devise/registrations#update
#                          PUT    /users(.:format)                            devise/registrations#update
#                          DELETE /users(.:format)                            devise/registrations#destroy
#    booking_builder_index POST   /bookings/:booking_id/builder(.:format)     bookings/builder#create
#      new_booking_builder GET    /bookings/:booking_id/builder/new(.:format) bookings/builder#new
#          booking_builder GET    /bookings/:booking_id/builder/:id(.:format) bookings/builder#show
#                          PATCH  /bookings/:booking_id/builder/:id(.:format) bookings/builder#update
#                          PUT    /bookings/:booking_id/builder/:id(.:format) bookings/builder#update
#                 bookings GET    /bookings(.:format)                         bookings#index
#                          POST   /bookings(.:format)                         bookings#create
#              new_booking GET    /bookings/new(.:format)                     bookings#new
#             edit_booking GET    /bookings/:id/edit(.:format)                bookings#edit
#                  booking GET    /bookings/:id(.:format)                     bookings#show
#                          PATCH  /bookings/:id(.:format)                     bookings#update
#                          PUT    /bookings/:id(.:format)                     bookings#update
#                          DELETE /bookings/:id(.:format)                     bookings#destroy
#                  clients GET    /clients(.:format)                          clients#index
#                          POST   /clients(.:format)                          clients#create
#               new_client GET    /clients/new(.:format)                      clients#new
#              edit_client GET    /clients/:id/edit(.:format)                 clients#edit
#                   client GET    /clients/:id(.:format)                      clients#show
#                          PATCH  /clients/:id(.:format)                      clients#update
#                          PUT    /clients/:id(.:format)                      clients#update
#                          DELETE /clients/:id(.:format)                      clients#destroy
#                   cities GET    /cities(.:format)                           cities#index
#                          POST   /cities(.:format)                           cities#create
#                 new_city GET    /cities/new(.:format)                       cities#new
#                edit_city GET    /cities/:id/edit(.:format)                  cities#edit
#                     city GET    /cities/:id(.:format)                       cities#show
#                          PATCH  /cities/:id(.:format)                       cities#update
#                          PUT    /cities/:id(.:format)                       cities#update
#                          DELETE /cities/:id(.:format)                       cities#destroy
#                 contacts POST   /contacts(.:format)                         contacts#create
#             new_contacts GET    /contacts/new(.:format)                     contacts#new
#                  drivers GET    /drivers(.:format)                          drivers#index
#                          POST   /drivers(.:format)                          drivers#create
#               new_driver GET    /drivers/new(.:format)                      drivers#new
#              edit_driver GET    /drivers/:id/edit(.:format)                 drivers#edit
#                   driver GET    /drivers/:id(.:format)                      drivers#show
#                          PATCH  /drivers/:id(.:format)                      drivers#update
#                          PUT    /drivers/:id(.:format)                      drivers#update
#                          DELETE /drivers/:id(.:format)                      drivers#destroy
#                copy_trip POST   /trips/:id/copy(.:format)                   trips#copy
#       trip_builder_index POST   /trips/:trip_id/builder(.:format)           trips/builder#create
#             trip_builder GET    /trips/:trip_id/builder/:id(.:format)       trips/builder#show
#                          PATCH  /trips/:trip_id/builder/:id(.:format)       trips/builder#update
#                          PUT    /trips/:trip_id/builder/:id(.:format)       trips/builder#update
#                          DELETE /trips/:trip_id/builder/:id(.:format)       trips/builder#destroy
#                    trips GET    /trips(.:format)                            trips#index
#                     trip GET    /trips/:id(.:format)                        trips#show
#                          DELETE /trips/:id(.:format)                        trips#destroy
#      route_builder_index POST   /routes/:route_id/builder(.:format)         routes/builder#create
#            route_builder GET    /routes/:route_id/builder/:id(.:format)     routes/builder#show
#                          PATCH  /routes/:route_id/builder/:id(.:format)     routes/builder#update
#                          PUT    /routes/:route_id/builder/:id(.:format)     routes/builder#update
#                          DELETE /routes/:route_id/builder/:id(.:format)     routes/builder#destroy
#                   routes GET    /routes(.:format)                           routes#index
#                    route GET    /routes/:id(.:format)                       routes#show
#                          DELETE /routes/:id(.:format)                       routes#destroy
#        bus_builder_index POST   /buses/:bus_id/builder(.:format)            buses/builder#create
#              bus_builder GET    /buses/:bus_id/builder/:id(.:format)        buses/builder#show
#                          PATCH  /buses/:bus_id/builder/:id(.:format)        buses/builder#update
#                          PUT    /buses/:bus_id/builder/:id(.:format)        buses/builder#update
#                          DELETE /buses/:bus_id/builder/:id(.:format)        buses/builder#destroy
#                    buses GET    /buses(.:format)                            buses#index
#                      bus GET    /buses/:id(.:format)                        buses#show
#                          DELETE /buses/:id(.:format)                        buses#destroy
#                     root GET    /                                           high_voltage/pages#show {:id=>"home"}
#                                 (/errors)/:status(.:format)                 errors#show {:status=>/\d{3}/}
#                     page GET    /*id                                        high_voltage/pages#show
