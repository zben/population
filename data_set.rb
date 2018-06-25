require 'json'

class DataSet
  attr_reader :data

  def initialize(input = File.open("/Users/ben/Downloads/zips.json").read)
    @data = Hash.new { |hash, key| hash[key] = {'pop' => 0, 'cities' => Hash.new(0) } }

    JSON.parse(input)['cities'].each do |data|
      state, pop, city = data['state'], data['pop'], data['city']
      @data[state]['pop'] += pop
      @data[state]['cities'][city] += pop
    end
  end

  def states_with_population_above_threshold(threshold)
    data.map do |state, stats|
      {_id: state, pop: stats['pop']} if stats['pop'] > threshold
    end.compact
  end

  def average_city_population_for(state)
    return unless data.keys.include?(state)

    cities_data = data[state] && data[state]['cities']

    {_id: state, avgCityPop: (cities_data.values.sum / cities_data.count)}
  end

  def largest_and_smallest_city_for(state)
    return unless data.keys.include?(state)

    cities_data = data[state] && data[state]['cities']

    max_pop = nil
    max_pop_city = nil
    min_pop = nil
    min_pop_city = nil

    cities_data.each do |city, pop|
      if max_pop.nil? || pop > max_pop
        max_pop = pop
        max_pop_city = city
      end

      if min_pop.nil? || pop < min_pop
        min_pop = pop
        min_pop_city = city
      end
    end

    {
      state: state,
      biggestCity: { name: max_pop_city, pop: max_pop },
      smallestCity: { name: min_pop_city, pop: min_pop }
    }
  end
end
