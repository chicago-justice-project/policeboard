class ConvertToRichText < ActiveRecord::Migration[6.1]
  include ActionView::Helpers::TextHelper
  def change
    rename_column :board_member_votes, :dissent_description, :dissent_description_old
    BoardMemberVote.all.each do |boardMemberVote|
      boardMemberVote.update_attribute(:dissent_description, simple_format(boardMemberVote.dissent_description_old))
    end
    remove_column :board_member_votes, :dissent_description_old

    rename_column :cases, :majority_decision, :majority_decision_old
    Case.all.each do |theCase|
      theCase.update_attribute(:majority_decision, simple_format(theCase.majority_decision_old))
    end
    remove_column :cases, :majority_decision_old

    rename_column :minority_opinions, :opinion_text, :opinion_text_old
    MinorityOpinion.all.each do |minorityOpinion|
      minorityOpinion.update_attribute(:opinion_text, simple_format(minorityOpinion.opinion_text_old))
    end
    remove_column :minority_opinions, :opinion_text_old

    rename_column :rules, :description, :description_old
    rename_column :rules, :comment, :comment_old
    Rule.all.each do |rule|
      rule.update_attribute(:description, simple_format(rule.description_old))
      rule.update_attribute(:comment, simple_format(rule.comment_old))
    end
    remove_column :rules, :description_old
    remove_column :rules, :comment_old

  end
end
