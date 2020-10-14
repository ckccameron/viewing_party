class RemoveDateTime < ActiveRecord::Migration[5.2]
  def change
    remove_column :parties, :date
    remove_column :parties, :start_time
  end
end
