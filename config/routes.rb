Sacobs::Application.routes.draw do

  devise_for :users

  resources :cities

  resources :routes

  resources :buses

  resources :trips

  resource :contacts, only: [:new, :create]

  resources :drivers

  resources :routes, only: [:index, :show, :destroy] do
   resources :builder, only: [:show, :update, :create],controller: 'routes/builder'
  end

  root to: 'high_voltage/pages#show', id: 'home'

  match '(errors)/:status', to: 'errors#show', constraints: {status: /\d{3}/}, via: :all

end
#== Route Map
# Generated on 07 Oct 2013 10:41
#
#         new_user_session GET    /users/sign_in(.:format)                   devise/sessions#new
#             user_session POST   /users/sign_in(.:format)                   devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)                  devise/sessions#destroy
#            user_password POST   /users/password(.:format)                  devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)              devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)             devise/passwords#edit
#                          PATCH  /users/password(.:format)                  devise/passwords#update
#                          PUT    /users/password(.:format)                  devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)                    devise/registrations#cancel
#        user_registration POST   /users(.:format)                           devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)                   devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)                      devise/registrations#edit
#                          PATCH  /users(.:format)                           devise/registrations#update
#                          PUT    /users(.:format)                           devise/registrations#update
#                          DELETE /users(.:format)                           devise/registrations#destroy
#                   cities GET    /cities(.:format)                          cities#index
#                          POST   /cities(.:format)                          cities#create
#                 new_city GET    /cities/new(.:format)                      cities#new
#                edit_city GET    /cities/:id/edit(.:format)                 cities#edit
#                     city GET    /cities/:id(.:format)                      cities#show
#                          PATCH  /cities/:id(.:format)                      cities#update
#                          PUT    /cities/:id(.:format)                      cities#update
#                          DELETE /cities/:id(.:format)                      cities#destroy
#                   routes GET    /routes(.:format)                          routes#index
#                          POST   /routes(.:format)                          routes#create
#                new_route GET    /routes/new(.:format)                      routes#new
#               edit_route GET    /routes/:id/edit(.:format)                 routes#edit
#                    route GET    /routes/:id(.:format)                      routes#show
#                          PATCH  /routes/:id(.:format)                      routes#update
#                          PUT    /routes/:id(.:format)                      routes#update
#                          DELETE /routes/:id(.:format)                      routes#destroy
#                    buses GET    /buses(.:format)                           buses#index
#                          POST   /buses(.:format)                           buses#create
#                  new_bus GET    /buses/new(.:format)                       buses#new
#                 edit_bus GET    /buses/:id/edit(.:format)                  buses#edit
#                      bus GET    /buses/:id(.:format)                       buses#show
#                          PATCH  /buses/:id(.:format)                       buses#update
#                          PUT    /buses/:id(.:format)                       buses#update
#                          DELETE /buses/:id(.:format)                       buses#destroy
#                 contacts POST   /contacts(.:format)                        contacts#create
#             new_contacts GET    /contacts/new(.:format)                    contacts#new
#        route_build_index GET    /routes/:route_id/build(.:format)          routes/build#index
#                          POST   /routes/:route_id/build(.:format)          routes/build#create
#          new_route_build GET    /routes/:route_id/build/new(.:format)      routes/build#new
#         edit_route_build GET    /routes/:route_id/build/:id/edit(.:format) routes/build#edit
#              route_build GET    /routes/:route_id/build/:id(.:format)      routes/build#show
#                          PATCH  /routes/:route_id/build/:id(.:format)      routes/build#update
#                          PUT    /routes/:route_id/build/:id(.:format)      routes/build#update
#                          DELETE /routes/:route_id/build/:id(.:format)      routes/build#destroy
#                          GET    /routes(.:format)                          routes#index
#                          POST   /routes(.:format)                          routes#create
#                          GET    /routes/new(.:format)                      routes#new
#                          GET    /routes/:id/edit(.:format)                 routes#edit
#                          GET    /routes/:id(.:format)                      routes#show
#                          PATCH  /routes/:id(.:format)                      routes#update
#                          PUT    /routes/:id(.:format)                      routes#update
#                          DELETE /routes/:id(.:format)                      routes#destroy
#                     root GET    /                                          high_voltage/pages#show {:id=>"home"}
#                                 (/errors)/:status(.:format)                errors#show {:status=>/\d{3}/}
#                     page GET    /*id                                       high_voltage/pages#show
