Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  scope '/:locale', locale: /en|fr/ do
    root to: 'application#index'
    devise_for :users,
               controllers: {
                   sessions: 'users/sessions',
                   registrationss: 'users/registrations',
                   passwords: 'users/passwords'
               }
  end

  get '', to: 'application#index', defaults: { locale: I18n.default_locale }

  localized do
    scope 'owner_signup',  controller: :owners do
      get '', as: :become_member, action: :new
      put :create
    end

    resources :live_sessions

    namespace :admin do
      get '/', to: 'application#index', as: :index

      resources :users do
        collection do
          get 'suggest'
        end
      end
      resources :sports
      resources :live_sessions
    end

    devise_scope :user do
      get 'login', to: 'users/sessions#new', as: 'login'
      post 'login', to: 'users/sessions#create'
      get 'signup', to: 'users/registrations#new', as: 'new_user'
    end
  end
end
