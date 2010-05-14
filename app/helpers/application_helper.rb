module ApplicationHelper
  
  def javascript(*script)
    content_for(:javascript) do 
      javascript_include_tag(*script)
    end
  end
  
  def stylesheet(*stylesheet)
    content_for(:stylesheet) do
      stylesheet_link_tag(*stylesheet)
    end
  end
  
  def title(page_title)
    content_for(:title) { " - " + page_title }
  end
  
end
