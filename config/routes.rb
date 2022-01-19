Rails.application.routes.draw do
  resources :rooms, only: %i[index] do 
    member do 
      post 'add_schedule', to: 'rooms#add_schedule'
    end
  end

  resources :schedules, only: %i[update destroy]
end
