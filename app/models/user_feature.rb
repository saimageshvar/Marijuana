class UserFeature < ActiveRecord::Base
	belongs_to :user
	belongs_to :feature
	has_many :logs
	validates_uniqueness_of :feature_id, scope: :user_id, message: "Such record already exists"
	serialize :period, Array
end
