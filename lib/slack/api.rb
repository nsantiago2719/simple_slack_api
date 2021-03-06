require 'httpclient'
module Slack
  class Api
    class << self
      def channel_data(token, channel_id)
        client = HTTPClient.new
        body = {
          'channel'   => channel_id,
          'token'     => token
        }
        ext_head = {
          'content-type'   => 'application/x-www-form-urlencoded'
        }
        res = client.get 'https://slack.com/api/channels.info', body, ext_head
        return JSON.parse res.body
      end

      def greetings_message(channel, token, text)
        client = HTTPClient.new
        body = {
          'channel'  => channel,
          'token'    => token,
          'as_user'  => false,
          'text'     => text,
          'username' => 'Mr. D'

        }
        ext_head = {
          'content-type'  => 'application/x-www-form-urlencoded'
        }
        res = client.post 'https://slack.com/api/chat.postMessage', body, ext_head
      end
    end
  end
end
