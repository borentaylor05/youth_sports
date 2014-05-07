module ApplicationHelper
	def full_title(page_title)
		base_title = "Youth Sports"
		if(page_title.empty?)
			return base_title
		else
			return "#{base_title} | #{page_title}"
		end
	end

	def gravatar_for(parent)
		gravatar_id = Digest::MD5::hexdigest(parent.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: parent.email, class: "gravatar")
	end
end
