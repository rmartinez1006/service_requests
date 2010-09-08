class CreateCatalogsUnits < ActiveRecord::Migration
  def self.up
    create_table :catalogs_units do |t|
      t.string :abbr
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :catalogs_units
  end
end
