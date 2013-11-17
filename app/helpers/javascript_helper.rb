module JavascriptHelper
  
  # Use this to set a value up in the viewbag which
  # allows you to access it from the asset pipeline JS files

  def viewbag(hash)
    properties = hash.collect { |k,v| "'#{j k.to_s}':'#{j v.to_s}'" }
    content_for :viewbag do 
      javascript_tag "document.viewbag = { #{properties.join(",")} };"
    end
  end

  # Check js exists prior to including it

  def javascript_include_tag_with_check(name)
    javascript_include_tag name if File.exists?("#{Rails.root}/app/assets/javascripts/#{name}.js.coffee")
  end
end
