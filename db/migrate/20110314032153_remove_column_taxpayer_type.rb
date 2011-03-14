class RemoveColumnTaxpayerType < ActiveRecord::Migration
  def self.up
    remove_column :catalogs_suppliers, :taxpayer_type
  end

  def self.down
  end
end
