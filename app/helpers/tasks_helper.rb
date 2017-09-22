module TasksHelper
	def from_and_to_dates
		content_tag(:div) do
			concat text_field_tag "user_feature[start_date]", nil, class: "datepicker"
			concat text_field_tag "user_feature[end_date]", nil, class: "datepicker"
		end
	end
end
