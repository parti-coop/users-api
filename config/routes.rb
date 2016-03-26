Rails.application.routes.draw do
  health_check_routes

  namespace :v1 do
    if Rails.env.test?
      namespace :test do
        resources :users, only: :index
      end
    end
  end
end
