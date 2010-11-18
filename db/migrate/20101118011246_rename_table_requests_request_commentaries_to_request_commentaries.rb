class RenameTableRequestsRequestCommentariesToRequestCommentaries < ActiveRecord::Migration
  def self.up
     rename_table :requests_request_commentaries, :request_commentaries
  end

  def self.down
     rename_table :request_commentaries, :requests_request_commentaries
  end
end
