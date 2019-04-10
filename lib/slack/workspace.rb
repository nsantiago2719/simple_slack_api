require 'uri'
module Slack
  class Workspace
    attr_accessor :workspace
    attr_accessor :scope
    attr_accessor :installed_by

    def init!(workspace, installed_by)
      @defaults = {
        :@slack_oauth        => 'https://slack.com/oauth/authorize',
        :@callback_uri       => ENV['CALLBACK_URI'],
        :@client_id          => ENV['SLACK_CLIENT_ID'],
        :@client_secret      => ENV['SLACK_CLIENT_SECRET'],
        :@scope              => %w(incoming-webhook),
        :@workspace          => workspace,
        :@installed_by       => installed_by
      }
    end

    def initialize(workspace, installed_by)
      init!(workspace, installed_by)
      reset!
    end

    def reset!
      @defaults.each do |k, v|
        instance_variable_set(k, v)
      end
    end

    def oauth_authorize_url
      parameters = {
        client_id: @client_id,
        scope: @scope.join(','),
        redirect_uri: redirect_uri
      }.to_query
      "#{@slack_oauth}?#{parameters}"
    end

    def redirect_uri
      parameters = {
        workspace: @workspace,
        installed_by: @installed_by
      }.to_query
      "#{@callback_uri}?#{parameters}"
    end
  end
end

