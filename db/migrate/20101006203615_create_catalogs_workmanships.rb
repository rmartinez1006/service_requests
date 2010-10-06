class CreateCatalogsWorkmanships < ActiveRecord::Migration
  def self.up
    create_table :catalogs_workmanships do |t|
      t.string :abbr
      t.string :description
      t.decimal :unit_cost, :precision => 10, :scale => 2, :default => 0
      t.string :unit_measure

      t.timestamps
    end
  end

  def self.down
    drop_table :catalogs_workmanships
  end
end
