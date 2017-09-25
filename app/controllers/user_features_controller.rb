class UserFeaturesController < ApplicationController
	include UserFeaturesHelper

	def create
		developer_ids = params[:user_feature][:user]
		developer_ids.reject!(&:blank?)
		developers = User.where("id in (?)", developer_ids)
		feature = Feature.find_by(id: params[:user_feature][:feature].to_i)
		begin
		  developers.each do |dev|
				dev.features << feature
			end
		rescue ActiveRecord::RecordInvalid => invalid
		  flash[:alert] = invalid.record.errors.full_messages
		end
		redirect_to dashboard_index_path(tab: 3) and return
	end

	def update
		user_feature = UserFeature.find_by(id: params[:id])
		if params[:user_feature][:duration].present? && (params[:user_feature][:start_date].empty? || params[:user_feature][:end_date].empty?)
			user_feature.duration = params[:user_feature][:duration].to_i
			start_date =  params[:user_feature][:start_date].present? ? params[:user_feature][:start_date].to_date : Date.current
			period = {start_date: start_date, end_date: start_date + user_feature.duration}
		else
			start_date = params[:user_feature][:start_date].to_date
			end_date = params[:user_feature][:end_date].to_date
			user_feature.duration = (end_date - start_date).to_i
			period = {start_date: start_date, end_date: end_date}
		end
		user_feature.period << period
		user_feature.working_days = get_without_weekends_and_misc(Array(period[:start_date]..period[:end_date]))
		user_feature.remaining = user_feature.working_days
		user_feature.save
		redirect_to dashboard_index_path and return
	end

end
