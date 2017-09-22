class UserFeaturesController < ApplicationController

	def create
		developer_ids = params[:user_feature][:user]
		developer_ids.reject!(&:blank?)
		developers = User.where("id in (?)", developer_ids)
		feature = Feature.find_by(id: params[:user_feature][:feature].to_i)
		developers.each do |dev|
			dev.features << feature
		end
		redirect_to dashboard_index_path and return
	end

	def update
		user_feature = UserFeature.find_by(id: params[:id])
		if params[:user_feature][:duration].present? && (params[:user_feature][:start_date].empty? || params[:user_feature][:end_date].empty?)
			user_feature.duration = params[:user_feature][:duration].to_i  
		else
			start_date = params[:user_feature][:start_date].to_date
			end_date = params[:user_feature][:end_date].to_date
			user_feature.duration = (end_date - start_date).to_i
			period = {start_date: start_date, end_date: end_date}
			user_feature.period << period
		end
		user_feature.remaining = user_feature.duration
		user_feature.save
		redirect_to dashboard_index_path and return
	end

end
