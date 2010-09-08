class CreateAdministrationUsers < ActiveRecord::Migration
  def self.up
    create_table :administration_users do |t|
      t.string :user
      t.string :name
      t.string :password
      t.string :email
      t.integer :role_id
      t.integer :ubication_id

      t.timestamps
    end
  end

  def self.down
    drop_table :administration_users
  end
end
