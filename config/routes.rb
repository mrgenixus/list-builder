Rails.application.routes.draw do
  devise_for :users
  resources :lists do
    resources :memberships, only: [:create, :destroy, :show]
  end
  resources :people
  resource :contact_form, controller: :contact_forms
  get '/:id/thank_you', to: 'contact_forms#thank_you', as: :sign_up_thank_you

  root to: "lists#index"
end
