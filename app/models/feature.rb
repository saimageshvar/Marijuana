class Feature < ActiveRecord::Base
	has_many :user_features
	has_many :users, through: :user_features
end
