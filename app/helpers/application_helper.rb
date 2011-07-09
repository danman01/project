module ApplicationHelper
  def title(page_title)
     content_for(:title){ page_title}
   end
   def description(meta_description)
     content_for(:description){meta_description}
   end
   def image(meta_image)
     content_for(:image){meta_image}
   end
   def load_function(body_onload_function)
     content_for(:load_function){body_onload_function}
   end
   
   def link_to_or(condition, alt, name, options = {}, html_options = {})
     if condition
       link_to(name, options, html_options)
     else
       alt
     end
   end
   def round_to(num, decimals=0 )
     factor = 10.0**decimals
     (num*factor).round / factor
   end

end
