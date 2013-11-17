class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
      t.decimal    :value, :precision => 4, :scale => 2
      t.references :wiggle
      t.timestamps
    end
  end
end
