#!/usr/bin/ruby

require "./Randomizer.rb"

# Die <inherits from Randomizer>
# -> initialize(sides:Int, colour:Enum) : constructor(i.e. `Die.new(sides, colour)`)
# -> colour() : returns the colour of the die (does NOT set it)
# -> sides() : returns the number of sides (does NOT set it)
# -> roll() : randomizes and returns the "rolled" die (for method chaining)
# -> sideup() : returns 1..sides or nil
# => to_s() : returns a string representation of a Die
# enum used for die colours = :red, :green, :blue, :yellow, :black, :white
# Description example: {item: :die, sides: 4, colour: :yellow, up: 4}
# Note 1: Int and Enum are only indications of the arg types expected by the method.
# -> They will not be present in your code as Ruby is Duck typed.
# -> UML type notation has been used, with the type following the arg name, separated by a colon
# Note 2: Enum is not actually a class; it is a duck-type-style interface, i.e. a protocol.
# -> E.g. colour is consistently represented by symbols such as `:red` and `:blue`;
# -> There is no class holding or enforcing these values (although they can be error checked against by the methods that accept them, if you wish).
# -> All enumeration protocols are listed in the "Enumerations" section later in the assignment
class Die < Randomizer
    COLOURS = [:red, :green, :blue, :yellow, :black, :white]

    attr_reader :sides, :colour

    def initialize(sides, colour)
        @item = :die
        @randomize_count = 0
        @result = nil
        raise ArgumentError, "Sides '#{sides}' is invalid - must be an integer of 1 or greater." unless sides.is_a?(Integer) && sides > 0
        @sides = sides
        raise ArgumentError, "Colour '#{colour}' is invalid - must be one of: #{COLOURS}." unless COLOURS.include?(colour)
        @colour = colour
    end

    def randomize
        @randomize_count += 1
        @result = 1 + rand(@sides)
        self
    end

    def roll
        self.randomize
    end

    def sideup
        self.result
    end

    def to_s
        "#{super}\nSides=#{@sides}\nColour=#{@colour}"
    end
end
