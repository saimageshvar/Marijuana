class UserFeature < ActiveRecord::Base
	belongs_to :user
	belongs_to :feature
	has_many :logs, dependent: :destroy
	validates_uniqueness_of :feature_id, scope: :user_id, message: "Such record already exists"
	serialize :period, Array

	def has_date_in_period?(date)
		self.duration.present? ? date.between?(self.period.first[:start_date], self.period.first[:end_date]) : false
	end
end
