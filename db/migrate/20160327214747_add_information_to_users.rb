class AddInformationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :information, :text
  end
end
