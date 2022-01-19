Rails.application.routes.draw do
  resources :rooms, only: %i[index]
end
