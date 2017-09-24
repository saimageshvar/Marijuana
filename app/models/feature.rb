class Feature < ActiveRecord::Base
	BASE_URL = "http://www.somedomain.com"

	has_many :user_features, dependent: :destroy
	has_many :users, through: :user_features
	attr_accessor :status

	def is_weekend_or_misc?(date)
		weekend = (date.wday == 0 || date.wday == 6)
		misc = Misc.find_by(misc_date: date.to_datetime).present?
		weekend || misc
	end

	def get_estimated_release_date(user_features = nil)
		user_features ||= self.user_features
		if user_features.collect(&:duration).reject(&:nil?).present?
			date = user_features.collect(&:period).flatten.collect{|p| p[:end_date]}.max
			date.to_formatted_s(:long)
		else
			"Not Estimated"
		end
	end

	def get_actual_release_date(user_features = nil)
		user_features ||= self.user_features
		estimated_date = self.get_estimated_release_date(user_features)
		if user_features.collect(&:duration).reject(&:nil?).present?
			actual_date = user_features.reject{ |uf| uf.duration.nil? }.collect{|p| p.period.first[:end_date] + (p.feature.off_track? ? p.remaining.abs.ceil : 0) }.max
			actual_date += 1 while is_weekend_or_misc?(actual_date)
			actual_date > estimated_date.to_date ? actual_date.to_formatted_s(:long) : estimated_date
		else
			"Not Estimated"
		end
	end

	def set_status_string(user_features = nil)
		user_features ||= self.user_features
		if user_features.collect(&:remaining).all?(&:nil?)
			self.status = "meh" 
		elsif user_features.collect(&:remaining).reject(&:nil?).any?(&:negative?)
			self.status = "off-track"
		elsif user_features.collect(&:period).reject(&:empty?).select{ |uf| uf.first[:end_date] < Date.current }.present?
			self.status = "off-track"
		else
			self.status = "on-track"
		end	
	end

	def off_track?
		self.status = self.set_status_string if self.status.nil?
		self.status == "off-track"
	end

	def on_track?
		self.status = self.set_status_string if self.status.nil?
		self.status == "on-track"
	end
end
