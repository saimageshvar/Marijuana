class CreateUserFeatures < ActiveRecord::Migration
  def change
    create_table :user_features do |t|
      t.integer :user_id
      t.integer :feature_id
      t.float :duration
      t.text :period

      t.timestamps null: false
    end
  end
end
