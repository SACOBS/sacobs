# == Route Map (Updated 2014-01-10 08:20)
#
#                   Prefix Verb   URI Pattern                                 Controller#Action
#                discounts GET    /discounts(.:format)                        discounts#index
#                          POST   /discounts(.:format)                        discounts#create
#             new_discount GET    /discounts/new(.:format)                    discounts#new
#            edit_discount GET    /discounts/:id/edit(.:format)               discounts#edit
#                 discount PATCH  /discounts/:id(.:format)                    discounts#update
#                          PUT    /discounts/:id(.:format)                    discounts#update
#                          DELETE /discounts/:id(.:format)                    discounts#destroy
#             print_ticket GET    /tickets/:id/print(.:format)                tickets#print
#             email_ticket POST   /tickets/:id/email(.:format)                tickets#email
#          download_ticket GET    /tickets/:id/download(.:format)             tickets#download
#                   ticket GET    /tickets/:id(.:format)                      tickets#show
#         print_trip_sheet GET    /trip_sheets/:id/print(.:format)            trip_sheets#print
#      download_trip_sheet GET    /trip_sheets/:id/download(.:format)         trip_sheets#download
#               trip_sheet GET    /trip_sheets/:id(.:format)                  trip_sheets#show
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
#          confirm_booking PATCH  /bookings/:id/confirm(.:format)             bookings#confirm
#           cancel_booking PATCH  /bookings/:id/cancel(.:format)              bookings#cancel
#    booking_builder_index POST   /bookings/:booking_id/builder(.:format)     bookings/builder#create
#      new_booking_builder GET    /bookings/:booking_id/builder/new(.:format) bookings/builder#new
#          booking_builder GET    /bookings/:booking_id/builder/:id(.:format) bookings/builder#show
#                          PATCH  /bookings/:booking_id/builder/:id(.:format) bookings/builder#update
#                          PUT    /bookings/:booking_id/builder/:id(.:format) bookings/builder#update
#                 bookings GET    /bookings(.:format)                         bookings#index
#                          POST   /bookings(.:format)                         bookings#create
#              new_booking GET    /bookings/new(.:format)                     bookings#new
#                  booking GET    /bookings/:id(.:format)                     bookings#show
#                          DELETE /bookings/:id(.:format)                     bookings#destroy
#             edit_setting GET    /setting/edit(.:format)                     settings#edit
#                  setting GET    /setting(.:format)                          settings#show
#                          PATCH  /setting(.:format)                          settings#update
#                          PUT    /setting(.:format)                          settings#update
#          client_vouchers POST   /clients/:client_id/vouchers(.:format)      vouchers#create
#       new_client_voucher GET    /clients/:client_id/vouchers/new(.:format)  vouchers#new
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
#            rails_db_info        /rails/info/db                              RailsDbInfo::Engine
#                     page GET    /*id                                        high_voltage/pages#show
#
# Routes for RailsDbInfo::Engine:
#          root GET /                                   rails_db_info/tables#index
# table_entries GET /tables/:table_id/entries(.:format) rails_db_info/tables#entries
#        tables GET /tables(.:format)                   rails_db_info/tables#index
#         table GET /tables/:id(.:format)               rails_db_info/tables#show
#

Sacobs::Application.routes.draw do
  resources :discounts, except: [:show]

  resources :tickets, only: [:show] do
    member do
      get :print
      post :email
      get :download
    end
  end

  resources :trip_sheets, only: [:show] do
   member do
     get :print
     get :download
   end
  end

  devise_for :users

  resources :bookings, only: [:create, :show, :index, :destroy] do
    member do
      patch :confirm
      patch :cancel
    end
    resources :builder, only: [:index, :show, :update], controller: 'bookings/builder'
    resources :payment_details, only: [:new, :create]
  end

  resource :setting, only: [:show, :edit, :update]

  resources :clients do
    resources :vouchers, only: [:new, :create]
  end

  resources :cities

  resource :contacts, only: [:new, :create]

  resources :drivers

  resources :trips, only: [:index, :show, :edit, :update ,:destroy] do
    member do
     post :copy
    end
    resources :builder, only: [:show, :update, :create],controller: 'trips/builder'
  end

  resources :routes, only: [:index, :show, :destroy] do
   resources :builder, only: [:show, :update, :create],controller: 'routes/builder'
  end

  resources :buses, only: [:index, :show, :edit, :update,:destroy] do
    resources :builder, only: [:show, :update, :create],controller: 'buses/builder'
  end

  root to: 'high_voltage/pages#show', id: 'home'

  match '(errors)/:status', to: 'errors#show', constraints: {status: /\d{3}/}, via: :all

end
