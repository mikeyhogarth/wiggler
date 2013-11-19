class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
      t.integer    :value, :limit => 1
      t.references :wiggle
      t.timestamps
    end
  end
end
