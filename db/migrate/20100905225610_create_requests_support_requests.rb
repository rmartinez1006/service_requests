class CreateRequestsSupportRequests < ActiveRecord::Migration
  def self.up
    create_table :requests_support_requests do |t|
      t.integer :request_no
      t.integer :ubication_id
      t.integer :helper_id
      t.integer :support_type_id
      t.string :name
      t.string :email
      t.text :description
      t.text :tech_description
      t.date :status_chng_date
      t.integer :status_id

      t.timestamps
    end
  end

  def self.down
    drop_table :requests_support_requests
  end
end
