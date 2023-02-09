Rails.application.routes.draw do
  resources :vulnerability_histories, only: %i[index show] do
    collection do
      get '/vulnerability/:id', to: 'vulnerability_histories#vulnerability'
    end
  end
  resources :vulnerabilities
  mount_devise_token_auth_for 'User', at: 'auth'
end
