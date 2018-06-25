require_relative 'data_set'

class ControlFlow
  def run
    puts "Below are the three features supported by this program."
    puts "1. Return States with Populations above 10 Million"
    puts "2. Return Average City Population by State"
    puts "3. Return Largest and Smallest Cities by State"

    while true
      puts "Which feature do you want to use? Enter the feature number. Enter 'quit' to quit."
      case gets.strip
      when "1"
        states_with_population_above_threshold_sequence
      when "2"
        average_city_population_sequence
      when "3"
        largest_and_smallest_city__sequence
      when "quit"
        exit
      end
    end
  end

  def data_set
    @data_set ||= DataSet.new
  end

  def states_with_population_above_threshold_sequence
    puts data_set.states_with_population_above_threshold(10_000_000).to_json
    puts
  end

  def average_city_population_sequence
    while true
      puts "Enter a two character state name in upper case like 'CA' and 'FL'. Enter 'quit' to quit."
      input = gets.strip

      if input == 'quit'
        break
      elsif result = data_set.average_city_population_for(input)
        puts result.to_json
        puts
        break
      end
    end
  end

  def largest_and_smallest_city__sequence
    while true
      puts "Enter a two character state name in upper case like 'CA' and 'FL'. Enter 'quit' to quit."
      input = gets.strip

      if input == 'quit'
        break
      elsif result = data_set.largest_and_smallest_city_for(input)
        puts result.to_json
        puts
        break
      end
    end
  end
end

ControlFlow.new.run
