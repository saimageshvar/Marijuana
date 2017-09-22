class AddWorkingDaysToUserFeatures < ActiveRecord::Migration
  def change
    add_column :user_features, :working_days, :float
  end
end
