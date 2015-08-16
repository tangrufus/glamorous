class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.belongs_to :user, null: false
      t.belongs_to :issue, null: false

      t.timestamps null: false
    end
    add_index :comments, :user_id
    add_index :comments, :issue_id
  end
end
