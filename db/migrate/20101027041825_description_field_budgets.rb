class DescriptionFieldBudgets < ActiveRecord::Migration
  def self.up
    add_column :budgets_budgets, :description, :text
  end

  def self.down
  end
end
