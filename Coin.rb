#!/usr/bin/ruby

# Course: CIS*3260: Software Design IV | A1: Ruby
# Name: Mitchell Van Braeckel
# Student Number: 1002297
# Email: mvanbrae@uoguelph.ca
# Due Date: September 27, 2021
# Professor: Mark Wineberg
# Language: Ruby

require "./Randomizer.rb"

# Coin <inherits from Randomizer>
# NOTE: enum used for coin denominations = 0.05, 0.10, 0.25, 1, 2
# NOTE: enum used for coin sides = :H, :T
# Description example: {item: :coin, denomination: 0.25, up: :H}
# Note 1: Int and Enum are only indications of the arg types expected by the method.
# -> They will not be present in your code as Ruby is Duck typed.
# -> UML type notation has been used, with the type following the arg name, separated by a colon
# Note 2: Enum is not actually a class; it is a duck-type-style interface, i.e. a protocol.
# -> E.g. colour is consistently represented by symbols such as `:red` and `:blue`;
# -> There is no class holding or enforcing these values (although they can be error checked against by the methods that accept them, if you wish).
# -> All enumeration protocolsare listed in the "Enumerations" section later in the assignment
class Coin < Randomizer
    # Constant array of valid Coin denominations ($CAD)
    DENOMINATIONS = [0.05, 0.10, 0.25, 1, 2]

    # Accessor method that returns the denomination of the Coin (does NOT set it)
    attr_reader :denomination

    # Default constructor for a Coin object (i.e. `Coin.new(denomination)`)
    def initialize(denomination)
        @item = :coin
        @randomize_count = 0
        @result = nil
        raise ArgumentError, "Denomination '#{denomination}' is invalid - must be one of: #{DENOMINATIONS}" unless DENOMINATIONS.include?(denomination)
        @denomination = denomination
    end

    # Overridden method that both randomizes and returns the Coin itself (for method chaining)
    def randomize
        @randomize_count += 1
        @result = rand(2) == 0 ? :T : :H
        self
    end

    # Flips the Coin and returns the "flipped" Coin (for method chaining) (synonym of Coin randomize())
    def flip
        self.randomize
    end

    # Returns `:H` or `:T` (the result of the last flip) or nil (if no flips yet done) (synonym of result())
    def sideup
        self.result
    end

    # Overriden method that returns the numerical value of the Coin flip result
    # NOTE: :H = 1 and :T = 0
    def result_value
        self.result
        result_value = self.result == :H ? 1 : 0
    end

    # # Returns if the given Coin is equal to self
    # def ==(o)
    #     o.is_a?(Coin) && super && self.denomination == o.denomination
    # end

    # # Overriden method that returns a string representation of the Coin
    # def to_s
    #     "#{super}, Denomination=#{@denomination}"
    # end
end
