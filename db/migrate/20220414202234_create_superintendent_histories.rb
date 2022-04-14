class CreateSuperintendentHistories < ActiveRecord::Migration[6.1]
  def change
    create_view :superintendent_histories
  end
end
