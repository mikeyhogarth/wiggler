module ApplicationHelper


  #primarily used for accessing initialization vars from the page JS
  def viewbag(hash)
    properties = hash.collect { |k,v| "'#{j k.to_s}':'#{j v.to_s}'" }
    content_for :viewbag do 
      javascript_tag "document.viewbag = { #{properties.join(",")} };"
    end
  end

end
