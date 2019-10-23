class ChangeContentOfComments < ActiveRecord::Migration[6.0]
  def change
    change_column :comments, :content, :string, default: "", null: false
  end
end
