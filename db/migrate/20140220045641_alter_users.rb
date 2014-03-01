class AlterUsers < ActiveRecord::Migration

  def up
    rename_table("users", "admin_users")
    add_column("admin_users", "username", :string, limit: 25, after: "email") #sequence is important
    change_column("admin_users", "email", :string, limit: 100) #any previous options get wiped away
    rename_column("admin_users", "password", "hashed_password")
    puts "*** Adding an index is next ***"
    add_index("admin_users", "username")
  end

  def down #in reverse order from 'up'
    remove_index("admin_users", "username")
    rename_column("admin_users", "hashed_password", "password")
    change_column("admin_users", "email", :string, default: "", null: false) #any previous options get wiped away
    remove_column("admin_users", "username") #sequence is important
    rename_table("admin_users", "users")
  end

end
