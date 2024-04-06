Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer if Rails.env.development?

  provider(
    :riotgames,
    Rails.application.credentials.dig(:riotgames, :client_id),
        Rails.application.credentials.dig(:riotgames, :client_secret),
    callback_path: '/auth/riotgames/callback'
    scope: 'openid',
  )
end