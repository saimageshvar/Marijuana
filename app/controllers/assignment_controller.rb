class AssignmentController < ApplicationController
	def index
		@features = Feature.all
		@assignment = UserFeature.new
		@assignments = UserFeature.includes(:feature, :user).all.order(User.table_name + ".email").group_by(&:user_id)
		@developers = User.includes(:roles).all.order(:email).select{ |u| u.has_role? User::DEVELOPER_ROLE }
	end
end
