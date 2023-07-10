Rails.application.routes.draw do
  #devise_for :employees
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # devise_for :employees, skip: [:registrations]
  resources :employees do
    collection do
      get 'find_department'
    end
    resource :personal_info
  end
end
