module PostsHelper
  def tags_size_valdiator(tagsSize)
   result = "+ "
   if (tagsSize - 1)> 0
    result += (tagsSize - 1).to_s + " more"
    result
   end
  end

  def tags_list(post)
    post.tags.map(&:name).map { |t| link_to t, tag_path(t) }.join(' ')
  end
end
