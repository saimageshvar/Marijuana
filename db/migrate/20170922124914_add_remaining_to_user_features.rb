class AddRemainingToUserFeatures < ActiveRecord::Migration
  def change
    add_column :user_features, :remaining, :float
  end
end
