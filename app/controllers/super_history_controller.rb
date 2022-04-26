class SuperHistoryController < ApplicationController
  def index
    @supers = Superintendent.order(last_name: :asc)
  end
end
