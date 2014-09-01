Rails.application.routes.draw do

  #Rutas de eventos
  get '/eventos' => 'evento#eventos', as: :lista_eventos_user
  get '/publicar' => 'evento#publicar', as: :publicar_evento
  post '/publicar' => 'evento#new', as: :eventos
  get '/editar/:id' => 'evento#editar', as: :editar_evento
  get '/admin-eventos' => 'evento#eventos_publicador', as: :lista_eventos_publicador
  get '/evento/:id  ' => 'evento#show', as: :mostrar_evento

  #Rutas de informacion de usuario
  get '/user/:id' => 'user#perfil', as: :perfil_user
  #testing
  get '/user/:id/editar' => 'user#editar', as: :editar_user
  #get '/user/:id/editarpasswd' => 'devise/passwords#edit',   :as => :edit_user_password
  #get '/user/:id/editarpasswd' => 'user#editarpasswd', as: :editarpasswd_user


  #Carpool
  get 'evento/:evento_id/carpool/publicar' => 'carpool#publicar', as: :publicar_carpool
  post 'evento/:evento_id/carpool/publicar' =>  'carpool#new', as: :new_publicar_carpool
  get 'evento/:evento_id/carpool/:id' => 'carpool#show', as: :mostrar_carpool
 


#  match '/profile/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  #Rutas para sobre escribir las rutas de devise
  devise_for :users,  :controllers => { omniauth_callbacks: 'omniauth_callbacks' }, :skip => [:sessions, :passwords, :confirmations, :registrations]
  as :user do
    #Registro
    get   '/registrarse' => 'devise/registrations#new',    :as => :new_user_registration
    post  '/registrarse' => 'devise/registrations#create', :as => :user_registration

    #Login
    get 'login' => 'devise/sessions#new', :as => :new_user_session
    post 'login' => 'devise/sessions#create', :as => :user_session
    match 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session,
      :via => Devise.mappings[:user].sign_out_via

    scope '/account' do
      # password reset
      get   '/resetpassword'        => 'devise/passwords#new',    :as => :new_user_password
      put   '/resetpassword'        => 'devise/passwords#update', :as => :user_password
      post  '/resetpassword'        => 'devise/passwords#create'
      get   '/resetpassword/change' => 'devise/passwords#edit',   :as => :edit_user_password

      # confirmation
      get   '/confirm'        => 'devise/confirmations#show',   :as => :user_confirmation
      post  '/confirm'        => 'devise/confirmations#create'
      get   '/confirm/resend' => 'devise/confirmations#new',    :as => :new_usern_confirmation

      # settings & cancellation
      get '/cancel'   => 'devise/registrations#cancel', :as => :cancel_user_registration
      get '/settings' => 'devise/registrations#edit',   :as => :edit_user_registration
      put '/settings' => 'devise/registrations#update'

      # account deletion
      delete '' => 'devise/registrations#destroy'
    end
    ## Mas rutas http://iampedantic.com/post/41170460234/fully-customizing-devise-routes
  end

  #Lo mismo de lo anterior pero para publicadores
  devise_for :publicadors, :skip => [:sessions, :passwords, :confirmations, :registrations]
  as :publicador do
    get 'cv-login' => 'devise/sessions#new', :as => :new_publicador_session
    post 'cv-login' => 'devise/sessions#create', :as => :publicador_session
    match 'cv-logout' => 'devise/sessions#destroy', :as => :destroy_publicador_session,
      :via => Devise.mappings[:publicador].sign_out_via
  end

  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end

  #comentarios
  resources :comments, :only =>[:create, :destroy]

  #activity
  resources :notifications

  root 'user#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
