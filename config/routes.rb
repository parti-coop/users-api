Rails.application.routes.draw do
  health_check_routes

  namespace :v1 do
    mount_devise_token_auth_for 'User', at: 'users', skip: [:omniauth_callbacks]

    if Rails.env.test?
      namespace :test do
        resources :users, only: [:index, :create]
      end
    end
  end
end
