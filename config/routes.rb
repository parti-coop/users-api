Rails.application.routes.draw do
  health_check_routes

  namespace :v1 do
    mount_devise_token_auth_for 'User', at: 'users', skip: [:omniauth_callbacks], controllers: {
      registrations: 'v1/registrations',
      sessions: 'v1/sessions'
    }

    if Rails.env.test?
      namespace :test do
        resources :users, only: [:index, :create, :destroy], param: :identifier do
          post 'verify-password', on: :member, to: 'users#verify_password'
        end
      end
    end
  end
end
