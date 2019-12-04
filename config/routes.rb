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
end
