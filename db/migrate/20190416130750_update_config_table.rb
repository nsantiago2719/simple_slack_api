class UpdateConfigTable < ActiveRecord::Migration[5.2]
  def change
    add_column :configs, :event_token, :string
  end
end
