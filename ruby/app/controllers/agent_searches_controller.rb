class AgentSearchesController < ApplicationController

  def show
    @search = AgentSearch.find(params[:id])
    @agents = Agent.where(id: @search.agent_ids.split(","))
  end

  def create
    search = AgentSearch.new(params.permit([:txn_side, :prop_type, AgentSearch::PRICE_RANGES.keys.map(&:to_sym)].flatten))

    if search.txn_side.blank? || search.prop_type.blank? || search.price_ranges.none?
      redirect_to(root_path)
      return
    end
    
    search.find_agent_matches!

    if search.save
      redirect_to agent_search_path(search)
    end

  end

end
