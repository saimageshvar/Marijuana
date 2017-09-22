module UserFeaturesHelper
	SUNDAY = 0
	SATURDAY = 6
	def get_without_weekends(date_range)
		weekends = [SATURDAY, SUNDAY]
		(date_range.collect(&:wday) - weekends).count
	end
end
