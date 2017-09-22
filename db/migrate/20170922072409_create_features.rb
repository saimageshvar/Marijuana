class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :ticket_id
      t.string :name
      t.string :description
      t.string :no_of_days
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
