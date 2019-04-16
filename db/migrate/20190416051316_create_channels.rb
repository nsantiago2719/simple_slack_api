class CreateChannels < ActiveRecord::Migration[5.2]
  def change
    create_table :channels do |t|
      t.string        :name
      t.string        :slack_id
      t.integer       :workspace_id
      t.timestamps
    end
  end
end
