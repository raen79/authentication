Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Swaggard::Engine, at: '/api_docs/swagger/'

  scope 'api' do
    scope 'authentication' do
      post '/login', :to => 'authentication#login'
      post '/register', :to => 'authentication#register'
      put '/verify_token', :to => 'authentication#verify_token'
    end
  end
end
