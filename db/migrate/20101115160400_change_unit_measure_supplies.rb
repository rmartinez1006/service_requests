class ChangeUnitMeasureSupplies < ActiveRecord::Migration
  def self.up
     change_column :budgets_budget_supplies, :unit_measure, :string
  end

  def self.down
  end
end
