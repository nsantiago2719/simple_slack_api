Rails.application.routes.draw do

  root 'omniauth#index'

  get '/oauth/install',   to: 'omniauth#install',   as: 'install'
  get '/oauth/callback',  to: 'omniauth#callback',  as: 'omniauth_callback'

  post '/oauth/authenticate', to: 'omniauth#authentication', as: 'auth'
  post '/events', to: 'event#challenge',   as: 'challenge'


end

