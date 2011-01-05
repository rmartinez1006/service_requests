class AddFieldsSuppliers < ActiveRecord::Migration
  def self.up
    add_column :catalogs_suppliers, :company_name, :string    
    add_column :catalogs_suppliers, :taxpayer_type, :string
    add_column :catalogs_suppliers, :taxpayer_reg, :string
    add_column :catalogs_suppliers, :postal_code, :string
  end

  def self.down
  end
end
