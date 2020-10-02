class AddIndexToPosts < ActiveRecord::Migration[6.0]

  def change
    add_index :posts, [:user_id, :created_at]
  end

end
