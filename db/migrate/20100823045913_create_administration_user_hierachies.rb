class CreateAdministrationUserHierachies < ActiveRecord::Migration
  def self.up
    create_table :administration_user_hierachies do |t|
      t.integer :user_id
      t.integer :helper_id

      t.timestamps
    end
  end

  def self.down
    drop_table :administration_user_hierachies
  end
end
