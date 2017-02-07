Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/apidocs' => 'apidocs#index'

      post   '/auth/token'  => 'auth#create'
      delete '/auth/token'  => 'auth#destroy'
      get    '/auth/me'     => 'auth#me'

      resources :users

      get '/clusters'  => 'clusters#index'
      get '/clusters/:id_or_name' => 'clusters#show', constraints: {id_or_name: /.+/}
      post '/clusters'  => 'clusters#create'
      put '/clusters/:id_or_name'  => 'clusters#update', constraints: {id_or_name: /.+/}
      patch '/clusters/:id_or_name'  => 'clusters#update', constraints: {id_or_name: /.+/}
      delete '/clusters/:id_or_name' => 'clusters#destroy', constraints: {id_or_name: /.+/}

      get '/aggregated_resources'  => 'resources#aggregated_resources'
      get '/resources'  => 'resources#index'
      get '/resources/:id_or_uri' => 'resources#show', constraints: {id_or_uri: /.+/}
      post '/resources'  => 'resources#create'
      put '/resources/:id_or_uri'  => 'resources#update', constraints: {id_or_uri: /.+/}
      patch '/resources/:id_or_uri'  => 'resources#update', constraints: {id_or_uri: /.+/}
      delete '/resources/:id_or_uri' => 'resources#destroy', constraints: {id_or_uri: /.+/}

      get '/jobs/:id_or_uri' => 'jobs#show', constraints: {id_or_uri: /.+/}
      post '/jobs'  => 'jobs#create'
      put '/jobs/:id_or_uri'  => 'jobs#update', constraints: {id_or_uri: /.+/}
      patch '/jobs/:id_or_uri'  => 'jobs#update', constraints: {id_or_uri: /.+/}
      delete '/jobs/:id_or_uri' => 'jobs#destroy', constraints: {id_or_uri: /.+/}
      put '/jobs'  => 'jobs#update'
      patch '/jobs'  => 'jobs#update'

      get '/messages'  => 'messages#index'
      post '/messages'  => 'messages#create'
      post '/fetch_messages'  => 'messages#index'
      get '/messages/last_id' => 'messages#last_id'

      get '/and_messages'  => 'and_messages#index'
      get '/and_messages/last_id' => 'and_messages#last_id'
      get '/or_messages'  => 'or_messages#index'
      get '/or_messages/last_id' => 'or_messages#last_id'
    end
  end
  get '/apidocs' => redirect('/swagger/dist/index.html?url=/api/v1/apidocs.json')
end
