class ChangePermalinkColumnTypeInPages < ActiveRecord::Migration
  def change
    change_column :pages, :permalink, :string
  end
end
