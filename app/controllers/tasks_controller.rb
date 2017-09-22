class TasksController < ApplicationController

	def index
		@tasks_without_deadline = current_user.user_features.where("duration is ? and period is ?", nil, nil)
	end

end
