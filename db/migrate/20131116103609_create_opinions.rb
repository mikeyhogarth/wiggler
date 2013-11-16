class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
      t.decimal    :value
      t.references :wiggle
      t.timestamps
    end
  end
end
