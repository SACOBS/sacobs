Sacobs::Application.routes.draw do

  get "route/index"
  get "route/new"
  get "route/create"
  get "route/show"
  get "route/edit"
  get "route/destroy"
  get "route/update"
  devise_for :users

  resources :cities

  resources :routes

  resources :buses

  resource :contacts, only: [:new, :create]

  root to: 'high_voltage/pages#show', id: 'home'

  match '(errors)/:status', to: 'errors#show', constraints: {status: /\d{3}/}, via: :all

end
#== Route Map
# Generated on 04 Oct 2013 14:36
#
#              route_index GET    /route/index(.:format)         route#index
#                route_new GET    /route/new(.:format)           route#new
#             route_create GET    /route/create(.:format)        route#create
#               route_show GET    /route/show(.:format)          route#show
#               route_edit GET    /route/edit(.:format)          route#edit
#            route_destroy GET    /route/destroy(.:format)       route#destroy
#             route_update GET    /route/update(.:format)        route#update
#         new_user_session GET    /users/sign_in(.:format)       devise/sessions#new
#             user_session POST   /users/sign_in(.:format)       devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)      devise/sessions#destroy
#            user_password POST   /users/password(.:format)      devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)  devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format) devise/passwords#edit
#                          PATCH  /users/password(.:format)      devise/passwords#update
#                          PUT    /users/password(.:format)      devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)        devise/registrations#cancel
#        user_registration POST   /users(.:format)               devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)       devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)          devise/registrations#edit
#                          PATCH  /users(.:format)               devise/registrations#update
#                          PUT    /users(.:format)               devise/registrations#update
#                          DELETE /users(.:format)               devise/registrations#destroy
#                   cities GET    /cities(.:format)              cities#index
#                          POST   /cities(.:format)              cities#create
#                 new_city GET    /cities/new(.:format)          cities#new
#                edit_city GET    /cities/:id/edit(.:format)     cities#edit
#                     city GET    /cities/:id(.:format)          cities#show
#                          PATCH  /cities/:id(.:format)          cities#update
#                          PUT    /cities/:id(.:format)          cities#update
#                          DELETE /cities/:id(.:format)          cities#destroy
#                   routes GET    /routes(.:format)              routes#index
#                          POST   /routes(.:format)              routes#create
#                new_route GET    /routes/new(.:format)          routes#new
#               edit_route GET    /routes/:id/edit(.:format)     routes#edit
#                    route GET    /routes/:id(.:format)          routes#show
#                          PATCH  /routes/:id(.:format)          routes#update
#                          PUT    /routes/:id(.:format)          routes#update
#                          DELETE /routes/:id(.:format)          routes#destroy
#                    buses GET    /buses(.:format)               buses#index
#                          POST   /buses(.:format)               buses#create
#                  new_bus GET    /buses/new(.:format)           buses#new
#                 edit_bus GET    /buses/:id/edit(.:format)      buses#edit
#                      bus GET    /buses/:id(.:format)           buses#show
#                          PATCH  /buses/:id(.:format)           buses#update
#                          PUT    /buses/:id(.:format)           buses#update
#                          DELETE /buses/:id(.:format)           buses#destroy
#                 contacts POST   /contacts(.:format)            contacts#create
#             new_contacts GET    /contacts/new(.:format)        contacts#new
#                     root GET    /                              high_voltage/pages#show {:id=>"home"}
#                                 (/errors)/:status(.:format)    errors#show {:status=>/\d{3}/}
#                     page GET    /*id                           high_voltage/pages#show
