class UsersAddFieldRole < ActiveRecord::Migration
  def self.up
    add_column :administration_users, :role, :string
  end

  def self.down
  end
end
