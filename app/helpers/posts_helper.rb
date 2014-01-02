module PostsHelper
  def get_like_text
    return (t 'posts.like', scope: :custom);    
  end
  
  def get_unlike_text
    return (t 'posts.unlike', scope: :custom);    
  end
  
end
