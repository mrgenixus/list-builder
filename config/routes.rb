Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: :callbacks }
  resources :lists do
    resources :memberships, only: [:create, :destroy, :show]
  end
  resources :people
  match '/contact_form', to: 'contact_forms#create', via: [:options]
  resources :contact_form, controller: :contact_forms
  get '/:id/thank_you', to: 'contact_forms#thank_you', as: :sign_up_thank_you

  root to: "lists#index"
end
