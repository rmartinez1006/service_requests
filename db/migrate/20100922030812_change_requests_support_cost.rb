class ChangeRequestsSupportCost < ActiveRecord::Migration
  def self.up
    add_column :requests_support_requests, :cost, :decimal
  end

  def self.down
  end
  
end
