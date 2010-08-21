class CreateCatalogsUbications < ActiveRecord::Migration
  def self.up
    create_table :catalogs_ubications do |t|
      t.string :abbr
      t.string :name
      t.string :responsible
      t.string :tel_ext
      t.integer :unit_id

      t.timestamps
    end
  end

  def self.down
    drop_table :catalogs_ubications
  end
end
