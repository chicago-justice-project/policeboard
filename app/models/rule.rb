class Rule < ActiveRecord::Base
include ActionView::Helpers::TextHelper
has_rich_text :description
has_rich_text :comment
  def item
     "Rule #{code} #{ description.to_plain_text.truncate(40)}"
  end
end