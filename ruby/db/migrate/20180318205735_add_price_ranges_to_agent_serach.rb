class AddPriceRangesToAgentSerach < ActiveRecord::Migration[5.1]
  def up
    add_column :agent_searches, :price_ranges, :text

    AgentSearch.transaction do
      AgentSearch.find_in_batches do |batch|
        batch.each do |search|
          search.update_attributes(price_ranges: [search.price_range])
        end
      end
    end
    
    change_column_null :agent_searches, :price_ranges, false
    remove_column :agent_searches, :price_range
  end

  def down
    add_column :agent_searches, :price_range, :string

    AgentSearch.transaction do
      AgentSearch.find_in_batches do |batch|
        batch.each do |search|
          search.update_attributes(price_range: [search.price_ranges.first])
        end
      end
    end

    change_column_null :agent_searches, :price_range, false
    remove_column :agent_searches, :price_ranges
  end
end
