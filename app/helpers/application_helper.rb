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
end
