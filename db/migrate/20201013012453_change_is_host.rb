class ChangeIsHost < ActiveRecord::Migration[5.2]
  def change
    change_column :guests, :is_host, :boolean, default: false
  end
end
