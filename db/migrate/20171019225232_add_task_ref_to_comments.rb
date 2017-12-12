class AddTaskRefToComments < ActiveRecord::Migration[5.1]
  def change
    add_reference :comments, :task, foreign_key: true
  end
end
