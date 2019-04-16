require 'httpclient'
module Slack
  class Api
    class << self
      def channel_data(token, channel_id)
        client = HTTPClient.new
        body = {
          'channel'   => channel_id
          'token'     => token
        }
        ext_head = {
          'content-type'   => 'application/x-www-form-urlencoded'
        }
        res = client.get 'https://slack.com/api/channels.info', body, ext_head
        return JSON.parse res
      end
    end
  end
end
