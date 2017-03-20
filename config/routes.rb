Rails.application.routes.draw do
  devise_for :users
  root 'chat_groups#index'
  resources :chat_groups ,only: %i(index new create edit update) do
    resources :messages , only: %i(index)
      end
end
