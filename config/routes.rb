Rails.application.routes.draw do
  resources :rooms, only: %i[index] do 
    member do 
      post 'add_schedule', to: 'rooms#add_schedule'
      patch 'edit_schedule', to: 'rooms#edit_schedule'
      delete 'cancel_schedule', to: 'rooms#cancel_schedule'
    end
  end
end
