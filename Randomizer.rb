#!/usr/bin/ruby

# An "abstract class" used for polymorphism and to store common methods
# -> randomize() : both randomizes and returns the randomizer itself (for method chaining)
# -> result() : returns the result of the randomization, or nil if never randomized
# -> randomize_count() : returns the number of randomizations performed
# -> reset() : sets the result to nil and number of randomizations performed to 0
# => up() : returns the up of the randomization (synonym of result())
# => result_value() : returns the numerical value of the randomization result
# => to_s() : returns a string representation of a Randomizer
# enum used for Randomizer items = :coin, :die
class Randomizer
    attr_reader :item

    def initialize
        @item = nil
        @result = nil
        @randomize_count = 0
    end

    def randomize
        raise NotImplementedError
    end

    def result
        (@randomize_count == nil || @randomize_count == 0) ? nil : @result
    end

    def result_value
        self.result
    end

    def randomize_count
        @randomize_count == nil ? 0 : @randomize_count
    end

    def reset
        @result = nil
        @randomize_count = 0
    end

    def up
        self.result
    end

    def to_s
        "Item=#{@item}\nRandomize Count=#{@randomize_count}\nResult=#{@result}"
    end
end
