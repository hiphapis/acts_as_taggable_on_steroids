require File.dirname(__FILE__) + '/abstract_unit'

class TagsHelperTest < Test::Unit::TestCase
	fixtures :tags, :taggings, :posts
	
	include TagsHelper
	
	def test_tag_cloud
		cloud_elements = []
		
		tag_cloud Post.tag_counts, %w(css1 css2 css3 css4) do |tag, css_class|
			cloud_elements << [tag, css_class]
		end
		
		assert_equal [
			[tags(:good), "css2"],
			[tags(:bad), "css1"],
			[tags(:nature), "css4"],
			[tags(:question), "css1"]
		], cloud_elements
	end
	
	def test_tag_cloud_when_no_tags
		tag_cloud SpecialPost.tag_counts, %w(css1) do
			assert false, "tag_cloud should not yield"
		end
	end

	#
	# link_to_*
	#
	def test_link_to_tag
		tag_name = "JustTest!"
		assert_equal link_to(tag_name, { :action => :tag, :id => tag_name }), link_to_tag(tag_name)
	end

	def test_link_to_tags
		tag_links = link_to_tags(Post.first)

		assert_equal "#{link_to_tag(Post.first.tags.first.name)}, #{link_to_tag(Post.first.tags.last.name)}", tag_links
	end
end
