namespace :credential do
  task :generator do |t, args|
    encryptor = ActiveSupport::MessageEncryptor
      .new(Rails.application.credentials.key)

    api_token = encryptor.encrypt_and_sign(ENV['APP_SECRET'])
    Config.create!(api_keys: api_token)

    puts "Please save the key given on safe and secured place. It'll only be showed once."
    puts "Token: #{api_token}"
  end
end
