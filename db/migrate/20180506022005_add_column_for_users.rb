class AddColumnForUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :reset_token, :integer
  end
end
