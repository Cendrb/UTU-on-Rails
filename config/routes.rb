UTUOnRails::Application.routes.draw do

  resources :articles

  resources :holidays


  post 'school_years/:id/generate_services_from' => 'school_years#generate_services_from'
  resources :school_years

  resources :sgroups

  post 'sclasses/change_current' => 'sclasses#change_current'
  resources :sclasses

  resources :class_members

  resources :group_categories

  post 'planned_raking_entries/sort' => 'planned_raking_entries#sort'
  post 'planned_raking_entries/mark_as_rekt' => 'planned_raking_entries#mark_as_rekt', as: "admin_show_planned_raking_entries_rekt"
  get 'planned_raking_entries/new_planned_rekt' => 'planned_raking_entries#new_planned_rekt', as: 'new_planned_rekt_raking_entry'
  get 'planned_raking_entries/new_already_rekt' => 'planned_raking_entries#new_already_rekt', as: 'new_already_rekt_raking_entry'
  resources :planned_raking_entries, except: :new


  get 'planned_raking_lists/admin_show/:id' => "planned_raking_lists#admin_show", as: "admin_show_planned_raking_lists"
  post 'planned_raking_lists/create_new_round/:id' => "planned_raking_lists#create_new_round", as: "create_new_round_planned_raking_lists"
  resources :planned_raking_lists

  resources :written_exams do
    controller :written_exams do
      get 'transform_to_raking' => :transform_to_raking
    end
  end

  resources :additional_infos

  resources :raking_exams do
    controller :raking_exams do
      get 'transform_to_written' => :transform_to_written
    end
  end

  get 'rake' => 'planned_raking_entries#new'

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

  controller :lessons do
    get 'lessons/dialog_for_timetable', as: :dialog_for_timetable
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
    end
  end

  resources :tasks do
    controller :tasks do
      get 'transform_to_exam' => :transform_to_exam
      get 'hide' => :hide
      get 'reveal' => :reveal
    end
  end

  resources :events do
    controller :events do
      get 'hide' => :hide
      get 'reveal' => :reveal
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root to: 'summary#summary', as: 'utu'

  # hiding - web uses get, apps use post
  post 'hiding/hide' => 'hiding#hide'
  post 'hiding/reveal' => 'hiding#reveal'
  get 'hiding/hide' => 'hiding#hide', as: 'hide_item'
  get 'hiding/reveal' => 'hiding#reveal', as: 'reveal_item'

  # for occasional data migrations
  get 'migrate' => 'summary#migrate'

  # just link to welcome screen
  get 'welcome_screen' => 'summary#welcome_screen'

  # enable experimental_settings
  get 'enable_experimental_settings' => 'users#enable_experimental_settings'

  # make external xml requests for details possible (without sclass and welcome_screen)
  get 'api/pre_data' => 'external_actions#pre_data'
  post 'api/pre_data' => 'external_actions#pre_data'
  get 'api/data' => 'external_actions#data'
  post 'api/data' => 'external_actions#data'
  get "api/only_details" => "external_actions#only_details"
  
  get 'analyze' => 'details_accesses#analyze'
  get 'statistics' => 'details_accesses#analyze'
  get 'stats' => 'details_accesses#analyze'
  
  get 'forgot' => 'users#forgot_password_form'
  get 'forgot_code' => 'users#forgot_password_code'
  post 'forgot' => 'users#forgot_password_send'
  
  get 'administrator_authenticated' => 'summary#administrator_logged_in'
  
  get 'subjects_summary' => 'summary#subjects'
  
  get 'vote' => 'day_teachers#new'
  
  get 'update' => 'summary#update'
  
  get 'details' => 'summary#details'
  post 'details' => 'summary#post_details'
  
  get 'rozvrh' => 'timetables#summary'
  get 'timetable' => 'timetables#summary'
  
  get 'service_list' => 'summary#service_list'
  
  get 'administration' => 'summary#administration'
  
  get 'register' => 'users#new'
  delete 'destroy_account/:id', to: 'users#self_destroy', as: 'destroy_account'


  # transform to selection dialog
  get 'show_transform_to_selection_dialog' => 'generic_actions#transform_to_selection_dialog'

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
