class AddEndingDateBudget < ActiveRecord::Migration
  def self.up
    add_column :budgets_budgets, :ending_date, :date
  end

  def self.down
  end
end
