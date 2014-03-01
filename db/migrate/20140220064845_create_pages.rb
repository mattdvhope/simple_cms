class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :subject_id
      t.string :name
      t.integer :permalink
      t.integer :position
      t.boolean :visible, default: false

      t.timestamps
    end
  end
end
