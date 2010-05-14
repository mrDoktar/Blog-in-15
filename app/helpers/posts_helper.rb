module PostsHelper
  
  # Note that it marks content as html_safe!
  def textilize_and_highlight(text)
    textilize(index_headings(code_highlight(text)))
  end
  
  def code_highlight(text)
    text.gsub(/\<code(?:(?:\s+title="([^"]+?)")|(?:\s+lang="([^"]+?)"))*\s*\>(.+?)\<\/code\>/m) do
      if $1.present?
        "\n" + content_tag(:notextile) do
          content_tag(:div, :class => "code") do
            content_tag(:h5, $1) + coderay($3, $2)
          end
        end + "\n"
      else
        content_tag(:notextile) do
          coderay($3, $2, :span)
        end
      end
    end
  end  
  
  def coderay(text, lang, type = :div)
    CodeRay.scan(text, lang).send(type, :css => :class).html_safe + " "
  end
  
  
  def tag_sentence(post)
    post.tags.collect{ |t| link_to t.name, posts_path(:tag => t.name, :anchor => "posts_list") }.to_sentence.html_safe
  end
  
  def index_headings(text)
    text.gsub(/h2\.\s(.+)/) do
      "<a name='#{$1.parameterize}'></a>\n\nh2. #{$1}"
    end
  end
  
  def list_headings(text)
    content_tag(:div, :class => "content") do
      content_tag(:h2, "In this post:") + 
      content_tag(:ul) do
        text.scan(/h2\.\s(.+)/).collect do |match|
          content_tag(:li, content_tag(:a, match, :href => "##{match.to_s.parameterize}"))
        end.join()
      end
    end
  end
end
