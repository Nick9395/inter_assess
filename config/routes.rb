Rails.application.routes.draw do
  devise_for :users

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "terms", to: "pages#terms", as: :terms
  resource :dashboard, only: :show
  resource :profile, only: [ :edit, :update, :destroy ]
  resources :practices, only: [ :new, :create, :show ] do
    resources :answers, only: :create, controller: "practice_answers"
  end

  root to: "pages#home"

  # 開発中のパスワードリセットメール確認用。gem 未読込時に全体のルートが消えないようにする。
  if Rails.env.development? && defined?(LetterOpenerWeb::Engine)
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
