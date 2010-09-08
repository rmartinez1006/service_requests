class CreateAdministrationUserRoles < ActiveRecord::Migration
  def self.up
    create_table :administration_user_roles do |t|
      t.string :rol
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :administration_user_roles
  end
end
