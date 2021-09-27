#!/usr/bin/ruby

require "./Randomizer.rb"

# An "abstract class" used for polymorphism and to store common methods
# -> store(r:Randomizer) : stores a randomizer in the container
# -> move_all(rc:RandomizerContainer) : get each randomizer in rc & store it in self
# -> empty() : removes all members of the container
# => copy_all(rc:RandomizerContainer) : get each randomizer in rc & store it in self (without emptying rc's randomizers)
# => to_s() : returns a string representation of a RandomizerContainer
# Note: All RandomizerContainer objects are created empty. Therefore they are just called with 'new' (e.g. `Cup.new`)
class RandomizerContainer
    def initialize
        @randomizers = []
    end

    def store(r)
        raise ArgumentError, "Randomizer '#{r}' is invalid - must be a Randomizer instance." unless r.is_a?(Randomizer)
        @randomizers << r
    end

    def copy_all(rc)
        raise ArgumentError, "RandomizerContainer '#{rc}' is invalid - must be a RandomizerContainer instance." unless rc.is_a?(RandomizerContainer)
        @randomizers += rc.randomizers
    end

    # todo - change move_all ? not allowed to have accessor for rc.randomizers ? Hand to Hand via next popping and storing, empty bag/cup to hand first
    # just changing to .clone instead should be fine
    def move_all(rc)
        self.copy_all(rc)
        rc.empty
    end

    def empty
        @randomizers = []
        nil
    end

    def randomizers
        @randomizers.clone
    end

    def to_s
        to_print = "Randomizer Container=#{self.class}\n"
        @randomizers.each do |r|
            to_print += "#{r.to_s.strip}\n"
        end
        to_print.strip
    end
end