class CreateAdministrationConfigurations < ActiveRecord::Migration
  def self.up
    create_table :administration_configurations do |t|
      t.integer :key
      t.string :value
      t.string :key_group

      t.timestamps
    end
  end

  def self.down
    drop_table :administration_configurations
  end
end
