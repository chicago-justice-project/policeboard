class BoardController < ApplicationController
  def index
    board_members = BoardMember.order(board_position: :asc, last_name: :asc)
    @current_board_members = board_members.select{ |bm| bm.active == true }
    @past_board_members = board_members.select{ |bm| bm.active == false }
  end

  def show
    @member = BoardMember.find(params[:id])

    @vote_bar_chart = [
      { :class => "agree", :size => @member.votes_agree_rate },
      { :class => "disagree", :size => @member.votes_dissent_rate },
      { :class => "novote", :size => @member.votes_abstain_rate}]
  
    if @member.votes_agree_rate > 10
      @vote_bar_chart[0].merge!(:symbol => "fa-check-circle", :display => "#{@member.votes_agree_rate}%")
    end
    if @member.votes_dissent_rate > 10
      @vote_bar_chart[1].merge!(:symbol => "fa-times-circle", :display => "#{@member.votes_dissent_rate}%")
    end
    if @member.votes_abstain_rate > 10
      @vote_bar_chart[2].merge!(:symbol => "fa-ban", :display => "#{@member.votes_abstain_rate}%")
    end 
  end

  def new
	@member = BoardMember.new()
  end
  
  def create
	@member = BoardMember.new(entry_params)
	if @member.save
		redirect_to board_path(@board), notice: 'Board successfully created'
	else
		render :new
	end
  end
  
  def update
	@member = BoardMember.find(params[:id])
	if @member.update_attributes(params)
		redirect_to board_path(@board), notice: 'Board successfully updated'
	else
		render :edit
	end
  end
  
  def board_params
	params.require(
  end
  
  
  def responsibilities
  end
  
  
  
  
end
