class AddPriceRangesToAgentSerach < ActiveRecord::Migration[5.1]
  def up
    price_ranges = %i{0to150k 150kto300k 300kto500k 500kto750k 750kto1m 1mplus}
    price_ranges.each do |range|
      add_column :agent_searches, range, :boolean, :default => false
    end

    AgentSearch.transaction do
      AgentSearch.find_in_batches do |batch|
        batch.each do |search|
          search.update_attributes(search.price_range.to_sym => true)
        end
      end
    end

    remove_column :agent_searches, :price_range
  end

  def down
    price_ranges = %i{0to150k 150kto300k 300kto500k 500kto750k 750kto1m 1mplus}
    add_column :agent_searches, :price_range, :string

    AgentSearch.transaction do
      AgentSearch.find_in_batches do |batch|
        batch.each do |search|
          range = price_ranges.detect{|range| search.send(range)}
          search.update_attributes(price_range: range.to_s)
        end
      end
    end

    change_column_null :agent_searches, :price_range, false
    price_ranges.each do |range|
      remove_column :agent_searches, range
    end
  end
end
