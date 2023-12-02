#!/usr/bin/ruby

MAX_PER_COLOUR = {
  red: 12,
  green: 13,
  blue: 14
}.freeze

games = File.readlines("inputs/02.txt")

result1 = games.sum do |game|
  game_no, sets = game.split(':')
  _, game_no = game_no.split(' ')

  valid = sets.split(';').all? do |grab|
    grab.split(',').all? do |amount_colour|
      amount, colour = amount_colour.strip.split(' ')
      amount.to_i <= MAX_PER_COLOUR[colour.to_sym]
    end
  end

  valid ? game_no.to_i : 0
end

puts "Day02::Part1: #{result1}"

# ====================================================

result2 = games.sum do |game|
  _, sets = game.split(':')

  sets.split(';').each_with_object({ red: 0, green: 0, blue: 0 }) do |grab, hash|
    grab.split(',').each do |amount_colour|
      amount, colour = amount_colour.strip.split(' ')
      hash[colour.to_sym] = amount.to_i if hash[colour.to_sym] < amount.to_i
    end

    hash
  end.values.inject(:*)

end

puts "Day02::Part2: #{result2}"
