module ApplicationHelper
  def body_id(body_id)
    content_for (:body_id) { body_id }
  end
  
  def navClass(controller)
    "current" if params[:controller] == controller || request.path.starts_with?('/' + controller)
  end

  def title(page_title)
    content_for (:title) { page_title }
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
	#raise association.inspect
   
    link_to(name,'#', class: "add_fields", data: {id: 0, fields: fields.gsub("\n",""), association: association}) 
  end

  def sort_link(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    icon = sort_direction == "asc" ? "&#x25B2" : "&#x25BC"
    icon = column == sort_column ? icon : ""
    link_to "#{title} <span class='#{icon}'>#{icon}</span>".html_safe, 
      params.permit(:per_page, :search, :sort, :direction).merge(sort: column, direction: direction)
  end

  def share_on_facebook
    link_to image_tag("/assets/facebook.png"), 'https://www.facebook.com/sharer.php?u='+request.original_url, target: :blank
  end

  def share_on_twitter(title)
    link_to image_tag("/assets/twitter.png"), 'https://twitter.com/share?text='+title+'&url='+request.original_url, target: :blank
  end
end
