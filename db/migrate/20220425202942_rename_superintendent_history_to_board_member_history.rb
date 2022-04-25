class RenameSuperintendentHistoryToBoardMemberHistory < ActiveRecord::Migration[6.1]
  def change
    rename_table :superintendent_histories, :board_member_histories
  end
end
