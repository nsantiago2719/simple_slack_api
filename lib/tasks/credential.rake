namespace :credential do
  task :generator do |t, args|
    encryptor = ActiveSupport::MessageEncryptor
      .new(Rails.application.credentials.key)

    api_token = encryptor.encrypt_and_sign(ENV['APP_SECRET'])
    Config.create!(api_keys: api_token)
  end
end
