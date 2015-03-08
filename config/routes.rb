UTUOnRails::Application.routes.draw do

  controller :charts do
    get 'accesses_per_hour_of_day'
    get 'accesses_per_hour_of_last_day'
    get 'accesses_per_day_of_week'
    get 'accesses_per_device'
    get 'accesses_per_user'
    get 'accesses_per_user_type'
    get 'accesses_per_ip'
    get 'accesses_per_last_month_in_days'
  end

  resources :details_accesses

  resources :baka_accounts

  resources :subjects

  resources :timetables do
    get 'fetch_baka' => :fetch_baka
  end

  resources :lessons

  resources :school_days

  resources :day_teachers

  resources :teachers

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'logout' => :destroy
  end

  resources :users

  resources :services

  resources :exams do
    controller :exams do
      get 'transform_to_task' => :transform_to_task
      get 'hide' => :hide
      get 'reveal' => :reveal
      post 'hide' => :hide
      post 'reveal' => :reveal
      post 'snooze' => :snooze
      post 'unsnooze' => :unsnooze
    end
  end

  resources :tasks do
    controller :tasks do
      get 'transform_to_exam' => :transform_to_exam
      get 'hide' => :hide
      get 'reveal' => :reveal
      post 'hide' => :hide
      post 'reveal' => :reveal
      post 'snooze' => :snooze
      post 'unsnooze' => :unsnooze
    end
  end

  resources :events do
    controller :events do
      get 'hide' => :hide
      get 'reveal' => :reveal
      post 'hide' => :hide
      post 'reveal' => :reveal
      post 'snooze' => :snooze
      post 'unsnooze' => :unsnooze
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root to: 'summary#summary', as: 'utu'

  get 'temp' => 'summary#temp'
  
  get 'analyze' => 'details_accesses#analyze'
  get 'statistics' => 'details_accesses#analyze'
  get 'stats' => 'details_accesses#analyze'
  
  get 'forgot' => 'users#forgot_password_form'
  get 'forgot_code' => 'users#forgot_password_code'
  post 'forgot' => 'users#forgot_password_send'
  
  get 'administrator_authenticated' => 'summary#administrator_logged_in'
  
  get 'subjects_summary' => 'summary#subjects'
  
  get 'vote' => 'day_teachers#new'
  
  get 'fetch_baka' => 'timetables#fetch_baka_for_all'
  
  get 'details' => 'summary#details'
  post 'details' => 'summary#post_details'
  
  get 'service_list' => 'summary#service_list'
  
  get 'administration' => 'summary#administration'
  
  get 'register' => 'users#new'
  delete 'destroy_account/:id', to: 'users#self_destroy', as: 'destroy_account'

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
