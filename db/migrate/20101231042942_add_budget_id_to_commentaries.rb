class AddBudgetIdToCommentaries < ActiveRecord::Migration
  def self.up
    add_column :request_commentaries, :budget_id, :integer
  end

  def self.down
    
  end
end
