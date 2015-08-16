class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :title, null: false
      t.integer :status, null: false, default: 0
      t.belongs_to :user, null: false

      t.timestamps null: false
    end
    add_index :issues, :title, unique: true
    add_index :issues, :status
    add_index :issues, :user_id
  end
end
