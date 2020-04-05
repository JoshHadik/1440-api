Rails.application.routes.draw do
  scope "api/v1", defaults: {format: :json} do
    devise_for :users
  end

  namespace :api do
    namespace :v1 do
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
