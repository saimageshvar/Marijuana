class Log < ActiveRecord::Base
	belongs_to :user_feature
	belongs_to :user
end
