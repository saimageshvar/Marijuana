class Misc < ActiveRecord::Base

	after_create :update_dependent_user_features_v1
	before_destroy :update_dependent_user_features_v2

	def update_dependent_user_features(flag)
		if self.is_a_weekday?
			user_features = UserFeature.all.select {|uf| uf.has_date_in_period?(self.misc_date)}
			user_features.each do |uf|
				flag ? (uf.working_days -= 1) : (uf.working_days += 1)
				uf.save
			end
		end
	end

	def update_dependent_user_features_v1
		update_dependent_user_features(true)
	end

	def update_dependent_user_features_v2
		update_dependent_user_features(false)
	end

	def is_a_weekday?
		self.misc_date.wday != 6 && self.misc_date.wday != 0
	end
end
