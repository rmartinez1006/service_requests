class AddOrderNumBudget < ActiveRecord::Migration
  def self.up
    add_column :budgets_budgets, :order_num, :string
  end

  def self.down
  end
end
