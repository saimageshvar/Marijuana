class CreateMiscs < ActiveRecord::Migration
  def change
    create_table :miscs do |t|
      t.datetime :misc_date
      t.string :description

      t.timestamps null: false
    end
  end
end
