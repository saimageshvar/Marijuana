class AssignmentController < ApplicationController
	def index
		@features = Feature.all
		@assignment = UserFeature.new
		@assignments = UserFeature.all
		@developers = User.includes(:roles).all.select{ |u| u.has_role? User::DEVELOPER_ROLE }
	end
end
