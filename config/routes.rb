NinetyNineCatsDay1::Application.routes.draw do
  get 'new/create'

  get 'new/User'

  get 'new/new'

  get 'new/create'

  get 'new/create'

  get 'new/User'

  resources :cats, except: :destroy
  resources :cat_rental_requests, only: [:create, :new] do
    post "approve", on: :member
    post "deny", on: :member
  end

  root to: redirect("/cats")
end
