class AddLectureToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :lecture, :string, default: "", null: false
  end
end
