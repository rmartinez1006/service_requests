class RenameColumnBudgetsBudgetsRequestIdToSupportRequestId < ActiveRecord::Migration
  def self.up
   rename_column :budgets_budgets, :request_id, :support_request_id
  end

  def self.down
   rename_column :budgets_budgets, :support_request_id, :request_id
  end
end
