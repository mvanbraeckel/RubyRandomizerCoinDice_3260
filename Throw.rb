#!/usr/bin/ruby

require "./Cup.rb"

# High Level Class : Throw
# -> initialize(cup:Cup) : constructor (i.e. Throw.new(cup))
# -> description(description:Hash) : Stores a description in the Throw from which the "randomizer" objects in the Throw can be selected when computing the results, tally or sum
# -> results() : Returns an array containing the "side-up" values of the randomizers recorded in the Throw.
# --> Only include the values from randomizers that match the description stored in the Throw. (If description() has not yet been called, return the results from all randomizers)
# -> tally() : Counts the items in the Throw that match the description and returns the value
# --> (If description() has not yet been called, count all randomizers)
# -> sum() : totals the value of the randomizer items in the Throw that match the description, where the value equals the number that is "up" (for coins, :H = 1 and :T = 0), and returns the value
# --> (If description() has not yet been called, total the values across all randomizers)
# => to_s() : returns a string representation of a Throw
# Description example: {item: :coin, denomination: 0.25, up: :H}
# Description example: {item: :die, sides: 4, colour: :yellow, up: 4}
class Throw
    def initialize(cup)
        @randomizers = []
        @description = {}
        raise ArgumentError, "Cup '#{cup}' is invalid - must be a Cup instance." unless cup.is_a?(Cup)
        @randomizers += cup.randomizers
    end

    def description(description)
        raise ArgumentError, "Description '#{description}' is invalid - must be a Hash." unless description.is_a?(Hash)
        @description = description
    end

    def results
        results_list = []
        self.description_filter.each do |r|
            results_list << r.result unless r.result == nil
        end
        results_list
    end

    def tally
        self.description_filter.length
    end

    def sum
        sum = 0
        self.description_filter.each do |r|
            sum += r.result_value
        end
        sum
    end

    def randomizers
        @randomizers.clone
    end

    def description_filter
        # Create a copy of the items to filter through based on description matches
        items = []
        items += self.randomizers
        @description.each do |k, v|
            items.select! { |r| k != nil && r.class.instance_methods.include?(k) && r.send(k) == v }
        end
        items
    end

    def to_s
        to_print = "Throw Randomizers:\n"
        @randomizers.each do |r|
            to_print += "#{r.to_s.strip}\n"
        end
        "Randomizers=#{to_print.strip}\nDescription=#{@description}\nResults=#{self.results}\nTally=#{self.tally}\nSum=#{self.sum}".strip
    end
end
