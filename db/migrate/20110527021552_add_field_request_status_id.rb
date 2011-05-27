class AddFieldRequestStatusId < ActiveRecord::Migration
  def self.up
    add_column :budgets_budgets, :status_id, :integer
  end

  def self.down
  end
end
