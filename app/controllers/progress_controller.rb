class ProgressController < ApplicationController
	
	def index
		@features = (current_user.has_role? User::ADMIN_ROLE) ? get_admin_view : get_developer_view
	end

	private

	def get_admin_view
		features = []
		user_features = UserFeature.includes(:feature, :user).all.group_by(&:feature_id)
		user_features.each do |key, value|
			feature = value.first.feature
			feature.status = "meh" if value.collect(&:remaining).all?(&:nil?)
			if value.collect(&:remaining).reject(&:nil?).any?(&:negative?)
				feature.status ||= "off-track"
			elsif value.collect(&:period).reject(&:empty?).select{ |uf| uf.first[:end_date] < Date.current }.present?
				feature.status ||= "off-track"
			else
				feature.status ||= "on-track"
			end	
			features << feature
		end
		features
	end

	def get_developer_view
		features = []
		user_features = UserFeature.where("feature_id in (?)", current_user.feature_ids)
		user_features = user_features.includes(:feature).all.group_by(&:feature_id)
		user_features.each do |key, value|
			feature = value.first.feature
			feature.set_status_string(value)
			features << feature
		end
		features
	end

end
