#!/usr/bin/ruby

inputs = File.readlines("inputs/01.txt")

result1 = inputs.map do |input|
  numbers = input.scan(/\d/)
  "#{numbers.first}#{numbers.last}".to_i
end.sum

puts "Day01::Part1: #{result1}"

REPLACEMENT_HASH = {
  'one' => 1, 'two' => 2, 'three' => 3, 'four' => 4, 'five' => 5,
  'six' => 6, 'seven' => 7, 'eight' => 8, 'nine' => 9
}.freeze

search_string = REPLACEMENT_HASH.keys.push('\d').join('|')

result2 = inputs.map do |input|
  numbers = input.scan(/(?=(#{search_string}))/).map { |match| REPLACEMENT_HASH.fetch(match[0], match[0]) }
  "#{numbers.first}#{numbers.last}".to_i
end.sum

puts "Day01::Part2: #{result2}"
