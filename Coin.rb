#!/usr/bin/ruby

require "./Randomizer.rb"

# Coin <inherits from Randomizer>
# -> initialize(denomination:Enum) : constructor (i.e. `Coin.new(denomination)`)
# -> denomination() : returns the denomination of the coin (does NOT set it)
# -> flip() : flips the coin and returns the "flipped" coin (for method chaining)
# -> sideup() : returns `:H` or `:T` (the result of the last flip) or nil (if no flips yet done)
# => to_s() : returns a string representation of a Coin
# enum used for coin denominations = 0.05, 0.10, 0.25, 1, 2
# enum used for coin sides = :H, :T
# Description example: {item: :coin, denomination: 0.25, up: :H}
# Note 1: Int and Enum are only indications of the arg types expected by the method.
# -> They will not be present in your code as Ruby is Duck typed.
# -> UML type notation has been used, with the type following the arg name, separated by a colon
# Note 2: Enum is not actually a class; it is a duck-type-style interface, i.e. a protocol.
# -> E.g. colour is consistently represented by symbols such as `:red` and `:blue`;
# -> There is no class holding or enforcing these values (although they can be error checked against by the methods that accept them, if you wish).
# -> All enumeration protocolsare listed in the "Enumerations" section later in the assignment
class Coin < Randomizer
    DENOMINATIONS = [0.05, 0.10, 0.25, 1, 2]

    attr_reader :denomination

    def initialize(denomination)
        @item = :coin
        @randomize_count = 0
        @result = nil
        raise ArgumentError, "Denomination '#{denomination}' is invalid - must be one of: #{DENOMINATIONS}" unless DENOMINATIONS.include?(denomination)
        @denomination = denomination
    end

    def randomize
        @randomize_count += 1
        @result = rand(2) == 0 ? :T : :H
        self
    end

    def flip
        self.randomize
    end

    def sideup
        self.result
    end

    def result_value
        self.result
        result_value = self.result == :H ? 1 : 0
    end

    def to_s
        "#{super}\nDenomination=#{@denomination}"
    end
end
