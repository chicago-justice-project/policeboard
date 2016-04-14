class Rule < ActiveRecord::Base
  def item
     "Rule#{code} #{description}"  
  end
end
