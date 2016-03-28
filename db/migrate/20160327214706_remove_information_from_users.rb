class RemoveInformationFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :information, :text
  end
end
