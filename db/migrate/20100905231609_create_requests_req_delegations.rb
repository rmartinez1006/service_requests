class CreateRequestsReqDelegations < ActiveRecord::Migration
  def self.up
    create_table :requests_req_delegations do |t|
      t.integer :request_id
      t.integer :user_id
      t.integer :helper_id
      t.integer :notify
      t.integer :priority_id
      t.integer :active

      t.timestamps
    end
  end

  def self.down
    drop_table :requests_req_delegations
  end
end
