Rails.application.routes.draw do
  get 'day/:date', to: 'day#show', as: 'day'
  devise_for :users, defaults: {format: :json}
  resources :activity_logs, only: [:show, :create, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
