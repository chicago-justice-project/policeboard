class RulesController < ApplicationController
  def index
    @rules = Rule.order(:code)
  end
end