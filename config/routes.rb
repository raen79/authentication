Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Swaggard::Engine, at: '/api_docs/swagger/'
end
