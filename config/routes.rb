Rails.application.routes.draw do
  resources :lists do
    resources :memberships, only: [:create, :destroy, :show]
  end
  resources :people

  root to: "lists#index"
end
