module PostsHelper
  
  # Note that it marks content as html_safe!
  def textilize_and_highlight(text)
    textilize(code_highlight(text))
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
  
end
