module JavascriptHelper
  
  # Check js exists prior to including it

  def javascript_include_tag_with_check(name)
    javascript_include_tag name if File.exists?("#{Rails.root}/app/assets/javascripts/#{name}.js.coffee")
  end
end
