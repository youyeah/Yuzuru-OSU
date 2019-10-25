class AddConditionToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :condition, :integer, null: false, default: 1
  end
end
