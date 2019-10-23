class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content
      t.references :provider, null: false, foreign_key: { to_table: :users }
      t.references :recipient, null: true, foreign_key: { to_table: :users }
      t.integer :status, null: false

      t.timestamps
    end
  end
end
