Rails.application.routes.draw do
  root "books#index"   # Home page
  resources :books do  # Generates index, show, new, create, edit, update, destroy
    get 'delete', on: :member
  end
end

