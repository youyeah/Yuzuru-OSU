class ChangeDatatypeStatusOfPosts < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :status, :integer, default: 0, null: false
  end
end
