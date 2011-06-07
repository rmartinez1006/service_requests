class AddFieldToCatalogsUbications < ActiveRecord::Migration
  def self.up
    add_column :catalogs_ubications, :available, :string
  end

  def self.down
  end
end
