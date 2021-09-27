#!/usr/bin/ruby

# Course: CIS*3260: Software Design IV | A1: Ruby
# Name: Mitchell Van Braeckel
# Student Number: 1002297
# Email: mvanbrae@uoguelph.ca
# Due Date: September 27, 2021
# Professor: Mark Wineberg
# Language: Ruby

# The testing file used to create and execute test cases with respect to the created use cases
# Description example: {item: :coin, denomination: 0.25, up: :H}
# Description example: {item: :die, sides: 4, colour: :yellow, up: 4}

require "./A1_Classes.rb"

DIE_SIDES = [4, 6, 8, 10, 12, 20, 30, 100]

# ================= USE CASE 1 =================

def test__dnd_backstabber_attack
    # Init necessary objects
    dirk = Player.new("Dirk Deacon")
    dirk.store(Coin.new(Coin::DENOMINATIONS.sample))
    for i in 0..2
        dirk.store(Die.new(20, Die::COLOURS.sample))
    end
    dirk.store(Die.new(8, Die::COLOURS.sample))

    # Attack roll using 1 coin and 3d20
    dirk.load({ item: :coin })
    dirk.load({ item: :die, sides: 20})
    dirk.throw

    # Damage roll using 1d8
    dirk.load({ sides: 8 })
    dirk.throw

    # Testing
    puts "\n-- 1. D&D Backstabber Attack --\n\n"

    puts "1. Player's number of throws is #{exp_1 = 2}"
    puts "Expected:\t#{exp_1}"
    puts "Actual:\t\t#{dirk.tally};length=#{res_1 = dirk.tally.length}"
    puts res_1 == exp_1 ? "--PASS--" : "--FAIL--"

    puts "2. Player's first throw was the attack roll"
    puts "Expected:\t1 coin and 3d20 results"
    puts "Actual:\t\t#{res_2 = dirk.results({}, 1)}"
    puts res_2.length == 4 ? "--PASS--" : "--FAIL--"

    puts "3. Player's second (most recent) throw was the damage roll"
    puts "Expected:\t1d8 results"
    puts "Actual:\t\t#{res_3 = dirk.results()}"
    puts res_3.length == 1 ? "--PASS--" : "--FAIL--"

    puts "4. Player notes the sum of both rolls, excluding the coin"
    puts "Expected:\tSum of 3d20s of attack roll"
    puts "Actual:\t\t#{res_4 = dirk.sum({item: :die})}"
    puts res_4[1] == res_2[1, res_2.length-1].sum ? "--PASS--" : "--FAIL--"

    puts "5. Now, the player erases turn throw history now that his turn is over"
    puts "Expected:\tempty array of results"
    puts "Actual:\t\t#{res_5 = dirk.clear}"
    puts res_5 == [] ? "--PASS--" : "--FAIL--"
end

def main_test_harness
    self.test__dnd_backstabber_attack
end

main_test_harness
