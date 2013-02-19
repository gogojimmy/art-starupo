module ApplicationHelper
  def footer_authors
    Author.all.sample(15)
  end

  def footer_posts
    Post.last(6)
  end
end
