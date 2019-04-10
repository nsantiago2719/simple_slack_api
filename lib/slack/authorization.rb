require 'httpclient'
require 'json'
require 'uri'

module Slack
  class Authorization
    class << self
      def oauth(code, redirect_uri)
        client = HTTPClient.new
        body = {
          'client_id'      => ENV['SLACK_CLIENT_ID'],
          'client_secret'  => ENV['SLACK_CLIENT_SECRET'],
          'code'           => code,
          'redirect_uri'   => redirect_uri
        }
        ext_head = {
          'content-type'  => 'application/x-www-form-urlencoded'
        }
        res = client.post('https://slack.com/api/oauth.access', body, ext_head)
        return JSON.parse res.body
      end
    end
  end
end

