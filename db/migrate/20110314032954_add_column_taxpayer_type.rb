class AddColumnTaxpayerType < ActiveRecord::Migration
  def self.up
    add_column :catalogs_suppliers, :taxpayer_type, :integer
  end

  def self.down
  end
end
