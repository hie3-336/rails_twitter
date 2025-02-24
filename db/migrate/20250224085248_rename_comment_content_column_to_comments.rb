class RenameCommentContentColumnToComments < ActiveRecord::Migration[7.0]
  def change
    rename_column :comments, :comment_content, :content
  end
end
