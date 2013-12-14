class AddStartAndEndToWiggles < ActiveRecord::Migration
  def change
    add_column :wiggles, :start, :datetime
    add_column :wiggles, :end, :datetime
  end
end
