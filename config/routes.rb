Rails.application.routes.draw do
  root "pages#index"

  # Auth
  get "auth/login", to: "sessions#login"
  get "auth/logout", to: "sessions#logout"
  get "auth/oidc/callback", to: "sessions#callback"
  get "auth/failure", to: "sessions#failure"
  get "api/auth/me", to: "sessions#me"

  # Pages
  get "stickers", to: "stickers#index"
  get "archive", to: "stickers#archive"
  get "my-designs", to: "designs#index"
  get "vote", to: "designs#all"
  get "dash", to: "pages#dashboard"
  get "trade", to: "pages#trade"
  get "designs", to: "pages#designs"

  # Shop
  get "shop", to: "shop#index"
  get "earn", to: redirect("/shop")
  get "api/shop/:id", to: "shop#show"

  # API
  post "api/designs", to: "designs#create"
  post "api/designs/:id/vote", to: "designs#vote"
  get "api/stickers/:id", to: "stickers#show"

  # Placeholders
  get "leaderboard", to: "pages#placeholder"
  get "vault", to: "pages#placeholder"

  # Health check for load balancers
  get "up" => "rails/health#show", as: :rails_health_check

  # Catch-all for 404 errors (must be last)
  match "*path", to: "pages#error_page", via: :all, constraints: lambda { |req|
    req.path.exclude?("rails/active_storage")
  }
end
