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
end
