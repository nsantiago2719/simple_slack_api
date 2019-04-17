class OmniauthController < ApplicationController
  before_action :set_workspace!, only: %w(install callback)
  before_action :verify_request, only: %w(index authentication)

  # none
  def index; end

  # callback action to be used on slack authorization
  def callback
    res = Slack::Authorization.oauth(workspace_data[:code], @slack_app.redirect_uri)
    if res['ok']
      @workspace.update workspace_token:   res['access_token'],
                        installed_date:    Time.zone.today,
                        team_name:         res['team_name'],
                        team_id:           res['team_id']
      bot = @workspace.bots.find_or_create_by bid: res['bot']['bot_user_id']
      bot.update token: res['bot']['bot_access_token']
    end
    redirect_to "https://#{@workspace.workspace}.slack.com/messages"
  end

  # generate redirect URI and rediret to slack callback
  def install
    redirect_to @slack_app.oauth_authorize_url
  end

  # returns authentication tokens needed by upstream
  def authentication
    workspace = Workspace.includes(:channels, :bots)
      .find_by(team_name: auth_request[:team_name])
    # get channel id
    channel_id = workspace
      .channels
      .select { |c| c.name == auth_request[:channel] }
      .first
      .slack_id
    bot_token = workspace.bots.first.token
    render json: { team_id: workspace.team_id,
                   channel_id: channel_id,
                   bot_token: bot_token
                 }, status: 200
  end

  private

  def authentication_data
    params.permit(:team_id, :channel)
  end

  def workspace_data
    params.permit(:installed_by, :workspace, :code)
  end

  # Looks or create workspace and create object Workspace
  def set_workspace!
    @workspace = Workspace.find_or_create_by(
      installed_by: workspace_data[:installed_by],
      workspace: workspace_data[:workspace]
    )
    @slack_app = Slack::Workspace.new(@workspace.workspace, @workspace.installed_by)
  end

  def auth_request
    params.permit(:team_name, :channel)
  end
end

