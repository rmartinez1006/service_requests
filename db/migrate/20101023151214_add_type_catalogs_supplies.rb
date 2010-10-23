class AddTypeCatalogsSupplies < ActiveRecord::Migration
  def self.up
    add_column :catalogs_supplies, :type, :integer
  end

  def self.down
  end
end
