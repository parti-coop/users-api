class AddIdentifierToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :identifier, :string, null: false
  end
end
