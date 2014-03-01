class CreateSectionEdits < ActiveRecord::Migration

  def up
    create_table :section_edits do |t|
      t.references :admin_user #for foreign key; same as t.integer :admin_user_id
      t.references :section    #for foreign key; same as t.integer :section_id
      t.string :summary #in this field we can provide a summary of the changes made; the presence of an admin_user (editor) editing a section
      t.timestamps
    end
    add_index :section_edits, ["admin_user_id", "section_id"]
  end

  def down
    drop_table :section_edits
  end

end
