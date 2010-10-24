class CreateBudgetsBudgetSupplies < ActiveRecord::Migration
  def self.up
    create_table :budgets_budget_supplies do |t|
      t.integer :type_supply
      t.integer :budget_id
      t.string :description
      t.decimal :unit_cost, :precision => 10, :scale => 2, :default => 0
      t.decimal :quantity, :precision => 10, :scale => 2, :default => 0
      t.decimal :unit_measure, :precision => 10, :scale => 2, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :budgets_budget_supplies
  end
end
