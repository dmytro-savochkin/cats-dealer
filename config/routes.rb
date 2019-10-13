Rails.application.routes.draw do
  root 'cats#index'

  resources :cats, only: %i[index] do
    collection do
      get :best_deal
    end
  end
end
