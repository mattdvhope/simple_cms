class SectionEdit < ActiveRecord::Base

  belongs_to :editor, :class_name => "AdminUser", :foreign_key => "admin_user_id" # since we're using :editor, we need to specify the :class_name and the :foreign_key(the foreign key that it should look for is "admin_user_id"--because it is not "editor_id")
  belongs_to :section

end
