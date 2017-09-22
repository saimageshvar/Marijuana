class ProgressController < ApplicationController
	
	def index
		@user_features, @features = (current_user.has_role? User::ADMIN_ROLE) ? get_admin_view : get_developer_view
	end

	private

	def get_admin_view
		features = []
		user_features = UserFeature.includes(:feature).all.group_by(&:feature_id)
		user_features.each do |key, value|
			feature = value.first.feature
			feature.status = value.collect(&:remaining).reject(&:nil?).any?(&:negative) ? "off-track" : "on-track"
			features << feature
		end
		return user_features, features
	end

	def get_developer_view
	end
end
