#!/usr/bin/ruby

require "./Hand.rb"
require "./Randomizer.rb"
require "./RandomizerContainer.rb"

# Bag <Inherits from RandomizerContainer> ; when store() or move_all() invoked, Bag makes sure that all randomizers added to the bag are reset
# -> select(description:Hash, amt=:all) : selects items from Bag based on the description and returns a Hand object that is holding the items up to the number entered into amount
# --> (if you want all items, supply the symbol :all instead of a number)
# -> empty() : empties all items from the Bag into a Hand, which is returned
# Note: All RandomizerContainer objects are created empty. Therefore they are just called with 'new' (e.g. `Cup.new`)
# Description example: {item: :coin, denomination: 0.25, up: :H}
# Description example: {item: :die, sides: 4, colour: :yellow, up: 4}
class Bag < RandomizerContainer
    def store(r)
        raise ArgumentError, "Randomizer '#{r}' is invalid - must be a Randomizer instance." unless r.is_a?(Randomizer)
        r.reset
        super
    end

    def move_all(rc)
        raise ArgumentError, "RandomizerContainer '#{rc}' is invalid - must be a RandomizerContainer instance." unless rc.is_a?(RandomizerContainer)
        rc.randomizers.each do |r|
            r.reset
        end
        super
    end

    def select(description, amt)
        raise ArgumentError, "Description '#{description}' is invalid - must be a Hash." unless description.is_a?(Hash)
        raise ArgumentError, "Amount '#{amt}' is invalid - must be an integer of 1 or greater." unless amt == :all || (amt.is_a?(Integer) && amt > 0)
        # Initialize the Hand to be returned and create a copy of the Bag's items to filter through based on description matches
        h = Hand.new
        items = []
        items += h.copy_all(self)
        description.each do |k, v|
            items.select! { |r| k != nil && r.class.instance_methods.include?(k) && r.send(k) == v }
        end

        # Limit the number of returned items by the amount desired, remove items from the bag and store in the Hand to be returned
        items = items.take(amt) unless amt == :all
        @randomizers -= items
        h.empty
        items.each do |item|
            h.store(item)
        end
        h
    end

    def empty
        h = Hand.new
        h.copy_all(self)
        super
        h
    end
end
