require 'spec_helper'

describe PostsHelper do

  include PostsHelper
  include ActionView::Helpers
  
  attr_accessor :output_buffer

  it "should textilize and color the post correctly" do
    text = 'h1. My header

<code lang="javascript" title="My title">
<script>
  var foo = "bar";
</script>
</code>

h2. More code

This is <code lang="html"><div></code> should be coloured.'

    formatted_text = '<h1>My header</h1>
<div class="code"><h5>My title</h5><div class="CodeRay">
  <div class="code"><pre>
<span class="ta">&lt;script&gt;</span>
  var foo = &quot;bar&quot;;
<span class="ta">&lt;/script&gt;</span>
</pre></div>
</div>
 </div><p><a name=\'more-code\'></a></p>
<h2>More code</h2>
<p>This is <span class="CodeRay"><span class="ta">&lt;div&gt;</span></span>  should be coloured.</p>'

    response = textilize_and_highlight(text)
    
    response.should == formatted_text
  end
end
