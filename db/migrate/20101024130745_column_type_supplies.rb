class ColumnTypeSupplies < ActiveRecord::Migration
  def self.up
    rename_column :catalogs_supplies, :type, :type_supply
  end

  def self.down
  end
end
