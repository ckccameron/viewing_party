class AddDatetimetoParties < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :datetime, :datetime
  end
end
