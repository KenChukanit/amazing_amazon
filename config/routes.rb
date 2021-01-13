Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 
  root "welcome#home"
  get("/home",{to: "welcome#home"})
  get("/about",{to: "welcome#about"})
  get("/contact_us",{to: "contact_us#index"})
  post("/thank_you",{to: "contact_us#thank_you", as: "contact_submit"})

  #Bill splitter
  get("/bill_splitter",{to: "bill_splitter#index"})
  post("/result",{to: "bill_splitter#result"})

  #Product routes
  # get '/products', to: 'products#index'
  # get '/products/new', to: 'products#new', as: :new_product
  # post '/products', to: 'products#create'

  # get('/products/:id', to: 'products#show', as: :product)
  # get('/products/:id/edit', to: "products#edit", as: :edit_product)
  # patch('/products/:id', to: "products#update")
  # delete("/products/:id",to: "products#destroy")
  resources :products do
    #All the resources in this block will be prefixed by this
    # /questions/:question_id
    # So we can now grab questio_id from params like params[:question_id]
    resources :reviews, only:[:create, :destroy]
     #this will only generate routes for :create and :destroy
     # like questions/:question_id/answers/:id
      # like questions/:question_id/answers/:id/edit
  end

end
