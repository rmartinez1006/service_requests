class PrepareUserTableToUseAuthlogic < ActiveRecord::Migration  
  def self.up
        rename_column :administration_users, :user, :username
        rename_column :administration_users, :password, :crypted_password
        add_column :administration_users, :password_salt, :string
        add_column :administration_users, :persistence_token, :string
  end

  def self.down
    rename_column :administration_users, :username, :user
    rename_column :administration_users, :crypted_password, :password
    remove_column :administration_users, :password_salt
    remove_column :administration_users, :persistence_token
  end
end
