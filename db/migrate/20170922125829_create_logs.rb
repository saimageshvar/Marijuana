class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :user_feature_id
      t.float :duration
      t.text :description

      t.timestamps null: false
    end
  end
end
