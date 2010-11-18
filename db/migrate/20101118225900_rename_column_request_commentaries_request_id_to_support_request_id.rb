class RenameColumnRequestCommentariesRequestIdToSupportRequestId < ActiveRecord::Migration
  def self.up
    rename_column :request_commentaries, :request_id, :support_request_id
  end

  def self.down
        rename_column :request_commentaries, :support_request_id, :request_id
  end
end
