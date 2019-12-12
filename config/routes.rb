Rails.application.routes.draw do
  get '/', to: 'welcome#index'
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'
  get '/pets', to: 'pets#index'
  get '/shelters/:id/pets', to: 'shelters#index_pets'
  get '/pets/:id', to: 'pets#show'
  get '/shelters/:id/pets/new', to: 'pets#new'
  post '/shelters/:id/pets', to: 'pets#create'
  get '/pets/:pet_id/edit', to: 'pets#edit'
  patch '/pets/:pet_id', to: 'pets#update'
  delete '/pets/:pet_id', to: 'pets#destroy'
  delete '/shelters/:id/pets', to:'shelters#destroy'
  get '/shelters/:shelter_id/new_review', to:'shelter_reviews#new'
  post '/shelters/:shelter_id', to: 'shelter_reviews#create'
  get '/shelters/:shelter_id/:review_id/edit_review', to: 'shelter_reviews#edit'
  patch '/shelters/:shelter_id/:review_id', to: 'shelter_reviews#update'
  delete '/shelters/:shelter_id/:review_id', to: 'shelter_reviews#destroy'
  patch '/favorites/:pet_id', to: 'favorites#update'
  get '/favorites', to: 'favorites#index'
  delete '/favorites/:pet_id', to: 'favorites#destroy'
  delete '/favorites', to: 'favorites#destroy'
  get '/applications/new', to: 'applications#new'
  post '/applications', to: 'applications#create'
  get '/applications/:app_id', to: 'applications#show'
  patch '/applications/:app_id/:pet_id', to: 'pet_applications#update'
  get '/pets/:pet_id/applications', to: 'pet_applications#index'
end
