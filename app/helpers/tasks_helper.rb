module TasksHelper
	def from_and_to_dates
		content_tag(:div) do
			concat text_field_tag "user_feature[start_date]", nil, class: "datepicker", required: true, value: Date.current.to_formatted_s(:long)
			concat text_field_tag "user_feature[end_date]", nil, class: "datepicker", placeholder: "End Date"
		end
	end
end
