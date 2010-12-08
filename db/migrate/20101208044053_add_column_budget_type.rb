class AddColumnBudgetType < ActiveRecord::Migration
  def self.up
    add_column :budgets_budgets, :budget_type, :integer
    # budget_type = 1 Presupuesto Interno, 2 Presupuesto Externo
  end

  def self.down
  end
end
