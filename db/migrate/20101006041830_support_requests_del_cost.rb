class SupportRequestsDelCost < ActiveRecord::Migration
  def self.up
    
  end

  def self.down
    remove_column :requests_support_requests, :cost
                   
  end
end
