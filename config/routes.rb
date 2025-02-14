Rails.application.routes.draw do

  get '/auth/:provider/callback', to: 'sessions#google_auth'
  get '/auth/failure', to: redirect('/')  # Optional failure route

  delete '/logout', to: 'sessions#logout'

  get '/profile', to: 'profiles#show'

  resources :surveys do
    member do
      post 'take'
      post 'distribute'
      get 'track'
    end
    resources :questions
    resources :responses do
      get 'answers', on: :member
    end
  end

  # post '/surveys/distribute', to: 'surveys#distribute'

  get 'attempted_surveys', to: 'surveys#attempted_surveys'
end
