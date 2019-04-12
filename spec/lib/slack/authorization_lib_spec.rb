require 'rails_helper'

RSpec.describe Slack::Authorization do
  describe '.oauth' do
    it 'should return false with invalid auth' do
      res = Slack::Authorization.oauth('xxxxx', 'https://redirect.com')
      expect(res['ok']).to_be eq(false)
    end
  end
end
