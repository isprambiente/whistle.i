Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :messages, except: [:edit, :destroy] do
    get :report, on: :collection
    get :list, on: :collection, defaults: { format: :json }, constraints: { format: :json }
    post :body, on: :member
    post :detail, on: :member
    post 'attachment/:attachment_id', on: :member, action: :attachment, as: :attachment
  end

  resources :users, only: [:index, :show, :update] do
    get :list, on: :collection, defaults: { format: :json }, constraints: { format: :json }
    post :add_key, on: :collection
    get :log, on: :member, defaults: { format: :json }, constraints: { format: :json }
  end

  get 'report', to: 'messages#report', as: :report

  root 'messages#new'

  devise_for :users, path: :auth #, controllers: { cas_sessions: 'my_cas' }
end
