class RenameTableRequestsSupportRequestsToRequestSupportRequests < ActiveRecord::Migration
  def self.up
     rename_table :requests_support_requests, :request_support_requests
  end

  def self.down
     rename_table :request_support_requests, :requests_support_requests
  end
end
