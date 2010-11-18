class RenameRequestsReqDelegationsToRequestDelegations < ActiveRecord::Migration
  def self.up
	rename_table :requests_req_delegations, :request_delegations
  end

  def self.down
	rename_table :request_delegations, :requests_req_delegations
  end
end
