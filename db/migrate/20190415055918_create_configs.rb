class CreateConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :configs do |t|
      t.string :api_keys, null: false
      t.datetime :last_used
      t.boolean :active
      t.timestamps
    end
  end
end
