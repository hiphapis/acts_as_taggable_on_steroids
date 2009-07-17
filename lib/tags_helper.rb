module TagsHelper
	# See the README for an example using tag_cloud.
	def tag_cloud(tags, classes)
		return if tags.empty?
		
		max_count = tags.sort_by(&:count).last.count.to_f
		
		tags.each do |tag|
			index = ((tag.count / max_count) * (classes.size - 1)).round
			yield tag, classes[index]
		end
	end


	def link_to_tag(tag, options = {})
		link_to tag, { :action => :tag, :id => tag }, options
	end

	def link_to_tags(tags, options = {})
		delimiter = options[:delimiter] || ", "
		tags.collect { |tag| link_to_tag(tag.name, options) }.join(delimiter)
	end
end
