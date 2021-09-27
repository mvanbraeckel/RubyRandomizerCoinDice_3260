#!/usr/bin/ruby

require "./Hand.rb"
require "./Randomizer.rb"
require "./RandomizerContainer.rb"

# Cup <Inherits from RandomizerContainer>
# -> throw() : each randomizer in the cup is rolled or flipped; virtual copies of all randomizers are stored in a newly created Throw object, which is returned
# -> load(hand:Hand) : enters each randomizer from a Hand (synonym of move_all())
# -> empty() : returns a Hand object to be returned to the bag, and leaves the cup empty
# Note: All RandomizerContainer objects are created empty. Therefore they are just called with 'new' (e.g. `Cup.new`)
class Cup < RandomizerContainer
    def throw
        @randomizers.each do |r|
            r.randomize unless r.instance_of?(Randomizer)
        end
        Throw.new(self)
    end

    def load(hand)
        raise ArgumentError, "Hand '#{hand}' is invalid - must be a Hand instance." unless hand.is_a?(Hand)
        self.move_all(hand)
    end

    def empty
        h = Hand.new
        h.copy_all(self)
        super
        h
    end
end
