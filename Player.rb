#!/usr/bin/ruby

require "./Bag.rb"
require "./Cup.rb"
require "./Randomizer.rb"

# High Level Class: Player
# -> initialize(name:String) : constructor (i.e. Player.new("Gandalf the Grey"))
# -> name() : returns the name of the player (does not set it)
# -> store(item:Randomizer) : stores the item in the player's bag
# -> move_all(rc:RandomizerContainer) : gets each item in rc and stores it in the player's bag
# -> load(description:Hash = { }) : loads items from the player's bag to the player's cup based on the description
# -> throw() : throws the (previously loaded) cup, and replaces the items in the cup to the bag (the throw is both returned and stored internally)
# -> clear() : clears all stored throws
# -> tally(description:Hash = { }) : sets the description, and calls tally() on each stored throw and returns each of the values within a single array
# -> sum(description:Hash = { }) : sets the description, and calls sum() on each stored throw and returns the combined values as an array
# -> results(description:Hash = { }, throw:Int = 0) : sets the description and returns the values as an array from given Throw, where the last Throw is "throw=0", the throw before is "throw=1", etc.
# --> If a throw is requested that doesn't exist (too far back in time and never occurred), return nil
# => to_s() : returns a string representation of a Player
# Description example: {item: :coin, denomination: 0.25, up: :H}
# Description example: {item: :die, sides: 4, colour: :yellow, up: 4}
class Player
    attr_reader :sides

    def initialize(name)
        raise ArgumentError, "Name '#{name}' is invalid - must be a String." unless name.is_a?(String)
        @name = name
        @bag = Bag.new
        @cup = Cup.new
        @throws = []
    end

    def store(item)
        raise ArgumentError, "Item '#{item}' is invalid - must be a Randomizer instance." unless item.is_a?(Randomizer)
        @bag.store(item)
    end

    def move_all(rc)
        @bag.move_all(rc)
    end

    def load(description = { })
        raise ArgumentError, "Description '#{description}' is invalid - must be a Hash." unless description.is_a?(Hash)
        @cup.load(@bag.select(description, :all))
    end

    def throw
        @throws.unshift(@cup.throw)
        @bag.move_all(@cup.empty)
    end

    def clear
        @throws = []
    end

    def tally(description = { })
        raise ArgumentError, "Description '#{description}' is invalid - must be a Hash." unless description.is_a?(Hash)
        throws_tallies = []
        @throws.each do |t|
            t.description(description)
            throws_tallies << t.tally
        end
        throws_tallies
    end

    def sum(description = { })
        raise ArgumentError, "Description '#{description}' is invalid - must be a Hash." unless description.is_a?(Hash)
        throws_sums = []
        @throws.each do |t|
            t.description(description)
            throws_sums << t.sum
        end
        throws_sums
    end

    def results(description = { }, throw = 0)
        raise ArgumentError, "Description '#{description}' is invalid - must be a Hash." unless description.is_a?(Hash)
        raise ArgumentError, "Throw ID '#{throw}' is invalid - must be an integer of 0 or greater." unless throw.is_a?(Integer) && throw >= 0
        if throw >= @throws.length
            nil
        else
            @throws[throw]
        end
    end

    def to_s
        to_print = "Player Throws:\n"
        @throws.each do |t|
            to_print += "#{t.to_s.strip}\n"
        end
        "Name=#{@name}\nBag:\n#{@bag.to_s.strip}\nCup:\n#{@cup.to_s.strip}\nThrows:\n#{to_print.strip}\nResults=#{self.results}\nTally=#{self.tally}\nSum=#{self.sum}"
    end
end
