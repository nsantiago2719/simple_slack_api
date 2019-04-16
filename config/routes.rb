Rails.application.routes.draw do

  root 'omniauth#index'

  get '/oauth/install',   to: 'omniauth#install',   as: 'install'
  get '/oauth/callback',  to: 'omniauth#callback',  as: 'omniauth_callback'

  post '/events/subscribe', to: 'event#challange',   as: 'challange'


end

