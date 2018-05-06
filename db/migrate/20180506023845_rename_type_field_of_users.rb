class RenameTypeFieldOfUsers < ActiveRecord::Migration[5.2]
  def self.up
    change_column :users, :reset_token, :string
  end

  def self.down
    change_column :users, :reset_token, :integer
  end
end
