module UserFeaturesHelper
	SUNDAY = 0
	SATURDAY = 6
	def get_without_weekends(date_range, return_array = false)
		weekends = [SATURDAY, SUNDAY]
		return_array ? (date_range.collect(&:wday) - weekends) : (date_range.collect(&:wday) - weekends).count
	end

	def get_without_misc(date_range, return_array = false)
		dates = (date_range - Misc.select(:misc_date).collect(&:misc_date).select{|d| (d.wday != 0) && (d.wday != 6) }.collect{|d| d.to_date})
		return_array ? dates : dates.size
	end

	def get_without_weekends_and_misc(date_range, return_array = false)
		dates = get_without_weekends(get_without_misc(date_range, true), true)
		return_array ? dates : dates.size
	end
end
