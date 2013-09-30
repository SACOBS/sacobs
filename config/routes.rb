Sacobs::Application.routes.draw do

  devise_for :users

  resources :cities, only: [:index]

  resource :contacts, only: [:new, :create]

  root to: 'high_voltage/pages#show', id: 'home'

  match '(errors)/:status', to: 'errors#show', constraints: {status: /\d{3}/}, via: :all

end
#== Route Map
# Generated on 30 Sep 2013 10:25
#
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
#                 contacts POST   /contacts(.:format)            contacts#create
#             new_contacts GET    /contacts/new(.:format)        contacts#new
#                     root GET    /                              high_voltage/pages#show {:id=>"home"}
#                     page GET    /*id                           high_voltage/pages#show
