class RenameColumnRequestSupportRequestsStatusIdToRequestStatusId < ActiveRecord::Migration
  def self.up
     rename_column :request_support_requests, :status_id, :request_status_id
  end

  def self.down
     rename_column :request_support_requests, :request_status_id, :status_id
  end
end
