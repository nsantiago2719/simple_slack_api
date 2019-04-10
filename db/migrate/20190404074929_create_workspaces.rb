class CreateWorkspaces < ActiveRecord::Migration[5.2]
  def change
    create_table :workspaces do |t|

      t.string        :installed_by
      t.string        :workspace
      t.datetime      :installed_date
      t.string        :workspace_token
      t.string        :webhook_url
      t.string        :team_name
      t.string        :channel

      t.timestamps
    end
  end
end

