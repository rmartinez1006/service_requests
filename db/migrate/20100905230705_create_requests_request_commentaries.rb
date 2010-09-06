class CreateRequestsRequestCommentaries < ActiveRecord::Migration
  def self.up
    create_table :requests_request_commentaries do |t|
      t.integer :request_id
      t.integer :user_id
      t.text :commentaries
      t.integer :comment_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :requests_request_commentaries
  end
end
