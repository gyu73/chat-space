Rails.application.routes.draw do
  devise_for :users
  root 'chat_groups#index'
  resources :chat_groups ,only: %i(index new edit) do
    resources :message , only: %i(index)
      end
end
