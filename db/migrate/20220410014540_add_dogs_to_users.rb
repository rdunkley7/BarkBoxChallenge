class AddDogsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :dogs, :user_id, :integer
    add_foreign_key :dogs, :user_id
  end
end
