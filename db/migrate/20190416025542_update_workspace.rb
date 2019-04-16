class UpdateWorkspace < ActiveRecord::Migration[5.2]
  def change
    remove_column :workspaces, :webhook_url, :string
    remove_column :workspaces, :channel,     :string
    add_column    :workspaces, :team_id,     :string
  end
end
