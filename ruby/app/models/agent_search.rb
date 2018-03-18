class AgentSearch < ApplicationRecord
  ###################################
  #
  #  Who: Full Stack Applicants, Backend Applicants, Data Applicants
  #
  #  Goal:
  #    To find a list of agents that best match the search parameters entered by the user. This
  #    is open to your interpretation. Your job is to think about what might matter to buyers/sellers
  #    and to implement a search function that effeciently finds a list.  See the Potential Considerations
  #    section below for starter ideas.
  #
  #  Reasoning: (please provide some commentary on your search algorithm)
  #
  #  Potential Considerations:
  #    - Buyers probably want people who have experience helping buyers, and same for sellers
  #    - Sellers probably want people who have experience selling their property type. Buyers might be more flexible
  #    - Buyers/Sellers at high price points are really picky about who they work with
  #    - Agents who work at higher price points really don't like working at low price points
  #
  ###################################
  PRICE_RANGES = {
    "0to150k" => "$0 - $150k",
    "150kto300k" => "$150k - $300k",
    "300kto500k" => "$300k - $500k",
    "500kto750k" => "$500k - $750k",
    "750kto1m" => "$750k - $1m",
    "1mplus" => "$1m+",
  }

  def find_agent_matches!
    self.agent_ids = Agent.all.map(&:id)
  end

end
