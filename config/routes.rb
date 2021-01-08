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
end
