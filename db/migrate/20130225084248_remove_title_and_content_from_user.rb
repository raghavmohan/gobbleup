class RemoveTitleAndContentFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :content
    remove_column :users, :title
  end

  def down
    add_column :users, :content, :text
    add_column :users, :title, :string
  end
end
