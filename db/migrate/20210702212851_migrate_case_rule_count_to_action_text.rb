class MigrateCaseRuleCountToActionText < ActiveRecord::Migration[6.1]
  include ActionView::Helpers::TextHelper
  def change
    rename_column :case_rule_counts, :content, :content_old
    CaseRuleCount.all.each do |caseRuleCount|
      caseRuleCount.update_attribute(:content, simple_format(caseRuleCount.content_old))
    end
    remove_column :case_rule_counts, :content_old
  end
end
