class CreateBudgetsBudgets < ActiveRecord::Migration
  def self.up
    create_table :budgets_budgets do |t|
      t.integer :request_id
      t.integer :supplier_id
      t.decimal :total_cost, :precision => 10, :scale => 2, :default => 0
      t.date :budget_date
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :budgets_budgets
  end
end
