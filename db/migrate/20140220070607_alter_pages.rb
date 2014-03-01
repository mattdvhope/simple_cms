class AlterPages < ActiveRecord::Migration

  def change
    add_index("pages", "subject_id")
    add_index("pages", "permalink")
  end

end
