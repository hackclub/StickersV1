# frozen_string_literal: true

OmniAuth.config.allowed_request_methods = %i[get post]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :openid_connect,
           name: :oidc,
           issuer: ENV.fetch("OIDC_ISSUER", "https://auth.hackclub.com"),
           discovery: true,
           client_options: {
             identifier: ENV.fetch("OIDC_CLIENT_ID", nil),
             secret: ENV.fetch("OIDC_CLIENT_SECRET", nil),
             redirect_uri: ENV.fetch("OIDC_REDIRECT_URI") { "#{ENV.fetch('APP_URL', 'http://localhost:3000')}/auth/oidc/callback" },
             host: "auth.hackclub.com",
             scheme: "https"
           },
           scope: %i[openid email profile]
end
