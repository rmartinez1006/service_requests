class CreateCatalogsSuppliers < ActiveRecord::Migration
  def self.up
    create_table :catalogs_suppliers do |t|
      t.string :abbr
      t.string :trade_name
      t.string :contact_name
      t.string :address
      t.string :mobile_phone
      t.string :business_phone

      t.timestamps
    end
  end

  def self.down
    drop_table :catalogs_suppliers
  end
end
