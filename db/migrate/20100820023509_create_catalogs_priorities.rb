class CreateCatalogsPriorities < ActiveRecord::Migration
  def self.up
    create_table :catalogs_priorities do |t|
      t.string :abbr
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :catalogs_priorities
  end
end
