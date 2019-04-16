class EventController < ApplicationController
  def challenge
    if challenge_data['challege'].present?
      url_callenge
    elsif members_joined_data['token'] == Config.first.event_token
      channel = register_workspace_channel
      bot_token = channel.workspace.bots.first.token
      res = Slack::Api.greetings_message(channel.slack_id,
                                   bot_token,
                                   "Thank you for adding me!!"
                                  )
      message = JSON.parse(res.body)
      render json: { body: message }, status: res.status
    else
      render json: { message: 'Unauthorized' }, status: 401
    end
  end

  def url_challenge
    Config.first.update event_token: token
    render json: { challenge: challegne_data['challenge'] }
  end

  def register_workspace_channel
    workspace = Workspace.find_by team_id: members_joined_data['team_id']
    bot_token = workspace.bots.first.token
    channel_info = Slack::Api.channel_data(bot_token,
                                           members_joined_data['event']['channel']
                                          )
    return workspace
      .channels
      .find_or_create_by(slack_id: channel_info['channel']['id'],
                         name: channel_info['channel']['name']
                        )
  end

  private

  def challenge_data
    params.permit(:token, :challenge, :type)
  end

  def members_joined_data
    params.permit(:token, :team_id, event: [ :channel ])
  end
end

