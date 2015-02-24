# == Route Map
#
#                      Prefix Verb                      URI Pattern                                         Controller#Action
#               apotomo_event GET|POST|PUT|PATCH|DELETE /:controller/render_event_response(.:format)        :controller#render_event_response
#            new_user_session GET                       /users/sign_in(.:format)                            devise/sessions#new
#                user_session POST                      /users/sign_in(.:format)                            devise/sessions#create
#        destroy_user_session DELETE                    /users/sign_out(.:format)                           devise/sessions#destroy
#               user_password POST                      /users/password(.:format)                           devise/passwords#create
#           new_user_password GET                       /users/password/new(.:format)                       devise/passwords#new
#          edit_user_password GET                       /users/password/edit(.:format)                      devise/passwords#edit
#                             PATCH                     /users/password(.:format)                           devise/passwords#update
#                             PUT                       /users/password(.:format)                           devise/passwords#update
#    cancel_user_registration GET                       /users/cancel(.:format)                             devise/registrations#cancel
#           user_registration POST                      /users(.:format)                                    devise/registrations#create
#       new_user_registration GET                       /users/sign_up(.:format)                            devise/registrations#new
#      edit_user_registration GET                       /users/edit(.:format)                               devise/registrations#edit
#                             PATCH                     /users(.:format)                                    devise/registrations#update
#                             PUT                       /users(.:format)                                    devise/registrations#update
#                             DELETE                    /users(.:format)                                    devise/registrations#destroy
#             search_bookings GET                       /bookings/search(.:format)                          bookings#search
#              daily_bookings GET                       /bookings/daily(.:format)                           bookings#daily
#        print_daily_bookings GET                       /bookings/print_daily(.:format)                     bookings#print_daily
#              cancel_booking PATCH                     /bookings/:id/cancel(.:format)                      bookings#cancel
#       booking_builder_index GET                       /bookings/:booking_id/builder(.:format)             bookings/builder#index
#             booking_builder GET                       /bookings/:booking_id/builder/:id(.:format)         bookings/builder#show
#                             PATCH                     /bookings/:booking_id/builder/:id(.:format)         bookings/builder#update
#                             PUT                       /bookings/:booking_id/builder/:id(.:format)         bookings/builder#update
#     booking_payment_details POST                      /bookings/:booking_id/payment_details(.:format)     payment_details#create
#  new_booking_payment_detail GET                       /bookings/:booking_id/payment_details/new(.:format) payment_details#new
#                    bookings GET                       /bookings(.:format)                                 bookings#index
#                             POST                      /bookings(.:format)                                 bookings#create
#                     booking GET                       /bookings/:id(.:format)                             bookings#show
#                             DELETE                    /bookings/:id(.:format)                             bookings#destroy
#                edit_setting GET                       /setting/edit(.:format)                             settings#edit
#                     setting GET                       /setting(.:format)                                  settings#show
#                             PATCH                     /setting(.:format)                                  settings#update
#                             PUT                       /setting(.:format)                                  settings#update
#              search_clients GET                       /clients/search(.:format)                           clients#search
#             client_vouchers POST                      /clients/:client_id/vouchers(.:format)              vouchers#create
#          new_client_voucher GET                       /clients/:client_id/vouchers/new(.:format)          vouchers#new
#                     clients GET                       /clients(.:format)                                  clients#index
#                             POST                      /clients(.:format)                                  clients#create
#                  new_client GET                       /clients/new(.:format)                              clients#new
#                 edit_client GET                       /clients/:id/edit(.:format)                         clients#edit
#                      client GET                       /clients/:id(.:format)                              clients#show
#                             PATCH                     /clients/:id(.:format)                              clients#update
#                             PUT                       /clients/:id(.:format)                              clients#update
#                             DELETE                    /clients/:id(.:format)                              clients#destroy
#               search_cities GET                       /cities/search(.:format)                            cities#search
#                      cities GET                       /cities(.:format)                                   cities#index
#                             POST                      /cities(.:format)                                   cities#create
#                    new_city GET                       /cities/new(.:format)                               cities#new
#                   edit_city GET                       /cities/:id/edit(.:format)                          cities#edit
#                        city GET                       /cities/:id(.:format)                               cities#show
#                             PATCH                     /cities/:id(.:format)                               cities#update
#                             PUT                       /cities/:id(.:format)                               cities#update
#                             DELETE                    /cities/:id(.:format)                               cities#destroy
#                    contacts POST                      /contacts(.:format)                                 contacts#create
#                new_contacts GET                       /contacts/new(.:format)                             contacts#new
#              search_drivers GET                       /drivers/search(.:format)                           drivers#search
#                     drivers GET                       /drivers(.:format)                                  drivers#index
#                             POST                      /drivers(.:format)                                  drivers#create
#                  new_driver GET                       /drivers/new(.:format)                              drivers#new
#                 edit_driver GET                       /drivers/:id/edit(.:format)                         drivers#edit
#                      driver GET                       /drivers/:id(.:format)                              drivers#show
#                             PATCH                     /drivers/:id(.:format)                              drivers#update
#                             PUT                       /drivers/:id(.:format)                              drivers#update
#                             DELETE                    /drivers/:id(.:format)                              drivers#destroy
#                   copy_trip POST                      /trips/:id/copy(.:format)                           trips#copy
#                search_trips GET                       /trips/search(.:format)                             trips#search
#              archived_trips GET                       /trips/archived(.:format)                           trips#archived
#       search_archived_trips GET                       /trips/search_archived(.:format)                    trips#search_archived
#          trip_builder_index POST                      /trips/:trip_id/builder(.:format)                   trips/builder#create
#                trip_builder GET                       /trips/:trip_id/builder/:id(.:format)               trips/builder#show
#                             PATCH                     /trips/:trip_id/builder/:id(.:format)               trips/builder#update
#                             PUT                       /trips/:trip_id/builder/:id(.:format)               trips/builder#update
#                       trips GET                       /trips(.:format)                                    trips#index
#                   edit_trip GET                       /trips/:id/edit(.:format)                           trips#edit
#                        trip GET                       /trips/:id(.:format)                                trips#show
#                             PATCH                     /trips/:id(.:format)                                trips#update
#                             PUT                       /trips/:id(.:format)                                trips#update
#                             DELETE                    /trips/:id(.:format)                                trips#destroy
#                  copy_route POST                      /routes/:id/copy(.:format)                          routes#copy
#          reverse_copy_route POST                      /routes/:id/reverse_copy(.:format)                  routes#reverse_copy
#     edit_route_destinations GET                       /routes/:route_id/destinations/edit(.:format)       destinations#edit
#          route_destinations PATCH                     /routes/:route_id/destinations(.:format)            destinations#update
#         route_builder_index POST                      /routes/:route_id/builder(.:format)                 routes/builder#create
#               route_builder GET                       /routes/:route_id/builder/:id(.:format)             routes/builder#show
#                             PATCH                     /routes/:route_id/builder/:id(.:format)             routes/builder#update
#                             PUT                       /routes/:route_id/builder/:id(.:format)             routes/builder#update
#                      routes GET                       /routes(.:format)                                   routes#index
#                  edit_route GET                       /routes/:id/edit(.:format)                          routes#edit
#                       route GET                       /routes/:id(.:format)                               routes#show
#                             PATCH                     /routes/:id(.:format)                               routes#update
#                             PUT                       /routes/:id(.:format)                               routes#update
#                             DELETE                    /routes/:id(.:format)                               routes#destroy
#           bus_builder_index POST                      /buses/:bus_id/builder(.:format)                    buses/builder#create
#                 bus_builder GET                       /buses/:bus_id/builder/:id(.:format)                buses/builder#show
#                             PATCH                     /buses/:bus_id/builder/:id(.:format)                buses/builder#update
#                             PUT                       /buses/:bus_id/builder/:id(.:format)                buses/builder#update
#                       buses GET                       /buses(.:format)                                    buses#index
#                    edit_bus GET                       /buses/:id/edit(.:format)                           buses#edit
#                         bus GET                       /buses/:id(.:format)                                buses#show
#                             PATCH                     /buses/:id(.:format)                                buses#update
#                             PUT                       /buses/:id(.:format)                                buses#update
#                             DELETE                    /buses/:id(.:format)                                buses#destroy
#          seasonal_discounts GET                       /seasonal_discounts(.:format)                       seasonal_discounts#index
#                             POST                      /seasonal_discounts(.:format)                       seasonal_discounts#create
#       new_seasonal_discount GET                       /seasonal_discounts/new(.:format)                   seasonal_discounts#new
#           seasonal_discount PATCH                     /seasonal_discounts/:id(.:format)                   seasonal_discounts#update
#                             PUT                       /seasonal_discounts/:id(.:format)                   seasonal_discounts#update
#                   discounts GET                       /discounts(.:format)                                discounts#index
#                             POST                      /discounts(.:format)                                discounts#create
#                new_discount GET                       /discounts/new(.:format)                            discounts#new
#               edit_discount GET                       /discounts/:id/edit(.:format)                       discounts#edit
#                    discount PATCH                     /discounts/:id(.:format)                            discounts#update
#                             PUT                       /discounts/:id(.:format)                            discounts#update
#                             DELETE                    /discounts/:id(.:format)                            discounts#destroy
#                     charges GET                       /charges(.:format)                                  charges#index
#                             POST                      /charges(.:format)                                  charges#create
#                  new_charge GET                       /charges/new(.:format)                              charges#new
#                 edit_charge GET                       /charges/:id/edit(.:format)                         charges#edit
#                      charge PATCH                     /charges/:id(.:format)                              charges#update
#                             PUT                       /charges/:id(.:format)                              charges#update
#                             DELETE                    /charges/:id(.:format)                              charges#destroy
#                       notes GET                       /notes(.:format)                                    notes#index
#                             POST                      /notes(.:format)                                    notes#create
#                    new_note GET                       /notes/new(.:format)                                notes#new
#                   edit_note GET                       /notes/:id/edit(.:format)                           notes#edit
#                        note PATCH                     /notes/:id(.:format)                                notes#update
#                             PUT                       /notes/:id(.:format)                                notes#update
#                             DELETE                    /notes/:id(.:format)                                notes#destroy
#                print_ticket GET                       /tickets/:id/print(.:format)                        tickets#print
#                email_ticket POST                      /tickets/:id/email(.:format)                        tickets#email
#             download_ticket GET                       /tickets/:id/download(.:format)                     tickets#download
#                      ticket GET                       /tickets/:id(.:format)                              tickets#show
#            print_trip_sheet GET                       /trip_sheets/:id/print(.:format)                    trip_sheets#print
#         download_trip_sheet GET                       /trip_sheets/:id/download(.:format)                 trip_sheets#download
#                 trip_sheets GET                       /trip_sheets(.:format)                              trip_sheets#index
#             edit_trip_sheet GET                       /trip_sheets/:id/edit(.:format)                     trip_sheets#edit
#                  trip_sheet GET                       /trip_sheets/:id(.:format)                          trip_sheets#show
#                             PATCH                     /trip_sheets/:id(.:format)                          trip_sheets#update
#                             PUT                       /trip_sheets/:id(.:format)                          trip_sheets#update
#                       users GET                       /users(.:format)                                    users#index
#                        user PATCH                     /users/:id(.:format)                                users#update
#                             PUT                       /users/:id(.:format)                                users#update
#          authenticated_root GET                       /                                                   dashboard#show
#                        root GET                       /                                                   pages#show {:id=>"home"}
#                        page GET                       /pages/*id                                          pages#show
#                     pricing GET                       /pricing/:id(.:format)                              pricing#show
#                 quick_quote GET                       /quick_quote(.:format)                              pricing#index
#                   dashboard GET                       /dashboard(.:format)                                dashboard#show
#                     reports GET                       /reports(.:format)                                  reports#index
#            generate_reports POST                      /reports(.:format)                                  reports#search
# reports_bookings_per_status GET                       /reports/bookings_per_status(.:format)              reports#bookings_per_status
#    reports_income_per_month GET                       /reports/income_per_month(.:format)                 reports#income_per_month
#   reports_bookings_per_user GET                       /reports/bookings_per_user(.:format)                reports#bookings_per_user
#                                                       (/errors)/:status(.:format)                         errors#show {:status=>/\d{3}/}
#

Sacobs::Application.routes.draw do

  get 'notes/create'

  get 'notes/destroy'

  devise_for :users

  resources :reports do
    member do
      get :print, defaults: { format: :pdf }
      get :download
    end
  end

  resources :bookings, only: [:create, :show, :index, :destroy] do
    collection do
      get :search
      get :daily
      get :print_daily, defaults: { format: :pdf }
    end
    member do
      patch :cancel
    end
    resources :builder, only: [:index, :show, :update], controller: 'bookings/builder'
    resources :payment_details, only: [:new, :create]
  end

  resource :setting, only: [:show, :edit, :update]

  resources :clients do
    collection do
      get :search
    end
    resources :vouchers, only: [:new, :create]
  end

  resources :cities do
    collection do
      get :search
    end
  end

  resource :contacts, only: [:new, :create]

  resources :drivers do
    collection do
      get :search
    end
  end

  resources :trips, only: [:index, :show, :edit, :update, :destroy] do
    member do
      post :copy
    end
    collection do
      get :search
      get :archived
      get :search_archived
    end
    resources :builder, only: [:show, :update, :create], controller: 'trips/builder'
  end

  resources :routes, only: [:index, :edit, :update, :show, :destroy] do
    member do
      post :copy
      post :reverse_copy
    end

    resources :destinations, only: [:none] do
      collection do
        get :edit
        patch :update
      end
    end
    resources :builder, only: [:show, :update, :create], controller: 'routes/builder'
  end

  resources :buses, only: [:index, :show, :edit, :update, :destroy] do
    resources :builder, only: [:show, :update, :create], controller: 'buses/builder'
  end

  resources :seasonal_discounts, except: [:show, :destroy, :edit]

  resources :discounts, except: [:show]

  resources :charges, except: [:show]

  resources :notes, except: [:show]

  resources :tickets, only: [:show] do
    member do
      get :print, defaults: { format: :pdf }
      post :email
      get :download
    end
  end

  resources :trip_sheets, only: [:show, :edit, :update, :index] do
    member do
      get :print, defaults: { format: :pdf }
      get :download
    end
  end

  resources :users, only: [:index, :update]

  authenticated :user do
    root to: 'dashboard#show', as: :authenticated_root
  end
  root to: 'pages#show', id: 'home'

  get '/pages/*id' => 'pages#show', as: :page, format: false

  get 'pricing/:id', to: 'pricing#show', as: :pricing
  get '/quick_quote', to: 'pricing#index', as: :quick_quote

  get '/dashboard', to: 'dashboard#show', as: :dashboard

  match '(errors)/:status', to: 'errors#show', constraints: { status: /\d{3}/ }, via: :all

end
