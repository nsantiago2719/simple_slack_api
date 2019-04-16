class CreateBots < ActiveRecord::Migration[5.2]
  def change
    create_table :bots do |t|
      t.string      :token
      t.string      :bid
      t.integer     :workspace_id
      t.timestamps
    end
  end
end
