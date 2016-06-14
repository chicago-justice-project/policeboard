class Rule < ActiveRecord::Base
include ActionView::Helpers::TextHelper
  def item
     "Rule #{code} #{ truncate(description, length: 40, separator: ' ')}"  
  end
end
