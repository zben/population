require "minitest/autorun"
require_relative 'data_set'

describe DataSet do
  describe '#initialize' do
    before do
      @raw_data = {cities: [
        { "_id" => "03275", "city" => "CITY A", "loc" => [ -71.439663, 43.147554 ], "pop" => 1, "state" => "CA" },
        { "_id" => "03276", "city" => "CITY A", "loc" => [ -71.57741300000001, 43.46033 ], "pop" => 2, "state" => "CA" },
        { "_id" => "03278", "city" => "CITY B", "loc" => [ -71.83534899999999, 43.303512 ], "pop" => 4, "state" => "CA" },
        { "_id" => "03278", "city" => "CITY A", "loc" => [ -71.83534899999999, 43.303512 ], "pop" => 5, "state" => "FL" }
      ]}.to_json
    end

    it 'adds up population of same city' do
      data_set = DataSet.new(@raw_data)

      assert_equal data_set.data['CA']['cities']['CITY A'], 3
      assert_equal data_set.data['CA']['cities']['CITY B'], 4
      assert_equal data_set.data['FL']['cities']['CITY A'], 5
    end

    it 'sums up population of states' do
      data_set = DataSet.new(@raw_data)

      assert_equal data_set.data['CA']['pop'], 7
      assert_equal data_set.data['FL']['pop'], 5
    end
  end

  describe '#states_with_population_above_threshold' do
    before do
      @raw_data = {cities: [
        { "_id" => "03275", "city" => "CITY A", "loc" => [ -71.439663, 43.147554 ], "pop" => 100, "state" => "CA" },
        { "_id" => "03276", "city" => "CITY A", "loc" => [ -71.57741300000001, 43.46033 ], "pop" => 300, "state" => "FL" }
      ]}.to_json
    end

    it 'returns correct state with population above threshold' do
      result = DataSet.new(@raw_data).states_with_population_above_threshold(200)

      assert_equal result, [{_id: 'FL', pop: 300}]
    end
  end

  describe '#average_city_population_for' do
    before do
      @raw_data = {cities: [
        { "_id" => "03275", "city" => "CITY A", "loc" => [ -71.439663, 43.147554 ], "pop" => 100, "state" => "CA" },
        { "_id" => "03276", "city" => "CITY B", "loc" => [ -71.57741300000001, 43.46033 ], "pop" => 300, "state" => "CA" }
      ]}.to_json
    end

    it 'returns correct average population' do
      result = DataSet.new(@raw_data).average_city_population_for('CA')

      assert_equal result, {_id: 'CA', avgCityPop: 200}
    end

    it 'returns nil for non existent state' do
      result = DataSet.new(@raw_data).average_city_population_for('AA')

      assert_nil result
    end
  end

  describe '#largest_and_smallest_city_for' do
    before do
      @raw_data = {cities: [
        { "_id" => "03275", "city" => "CITY A", "loc" => [ -71.439663, 43.147554 ], "pop" => 300, "state" => "CA" },
        { "_id" => "03276", "city" => "CITY B", "loc" => [ -71.439663, 44.147554 ], "pop" => 100, "state" => "CA" },
        { "_id" => "03277", "city" => "CITY C", "loc" => [ -71.439663, 45.147554 ], "pop" => 200, "state" => "CA" },
      ]}.to_json
    end

    it 'returns correct largest and smallest city' do
      result = DataSet.new(@raw_data).largest_and_smallest_city_for('CA')

      assert_equal result, {state: 'CA', biggestCity: { name: 'CITY A', pop: 300}, smallestCity: { name: 'CITY B', pop: 100}}
    end

    it 'returns nil for non existent state' do
      result = DataSet.new(@raw_data).largest_and_smallest_city_for('AA')

      assert_nil result
    end
  end
end
