class AddFieldsToBudget < ActiveRecord::Migration
  def self.up
     add_column :budgets_budgets, :unit_cost, :decimal, :precision => 10, :scale => 2, :default => 0
     add_column :budgets_budgets, :quantity, :decimal, :precision => 10, :scale => 2, :default => 0
     add_column :budgets_budgets, :unit_measure, :string
  end

  def self.down
  end
end
