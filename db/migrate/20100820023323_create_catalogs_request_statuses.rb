class CreateCatalogsRequestStatuses < ActiveRecord::Migration
  def self.up
    create_table :catalogs_request_statuses do |t|
      t.string :abbr
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :catalogs_request_statuses
  end
end
