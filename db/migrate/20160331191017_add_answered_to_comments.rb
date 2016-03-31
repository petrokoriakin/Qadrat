class AddAnsweredToComments < ActiveRecord::Migration
  def change
    add_column :comments, :is_answer, :boolean, default: false
  end
end
