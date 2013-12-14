module NavigationHelper
  def breadcrumbs(trail)

    #Add in the root URL (so we don't need to do this in every view)
    trail = [link_to("Home",root_url)] + trail
    
    #Build the nav
    content_tag(:nav, :class => :breadcrumbs) do
      last_item = trail.pop

      trail.each do |item|
        #If the item is just text, put in a link so foundation renders it correctly
        item = link_to(item,"#") unless item.to_s.include? "href"
        concat item
      end

      #Finally whack in the current breadcrumb
      concat link_to(last_item, "#", :class => "current")
    end
  end
end
