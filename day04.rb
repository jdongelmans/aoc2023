#!/usr/bin/ruby

inputs = File.readlines('inputs/04.txt', chomp: true)
# inputs = <<-STRING
# Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
# Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
# Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
# Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
# Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
# Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
# STRING
# inputs = inputs.split("\n")

result1 = inputs.sum do |card|
  _, numbers = card.split(':')
  winning, yours = numbers.split('|').map(&:strip)

  winning = winning.split(' ')
  yours = yours.split(' ')

  wins = (winning & yours).size
  wins.positive? ? (2**(wins - 1)) : 0
end

puts "Day04::Part1: #{result1}"

# ====================================================

result2 = inputs.count do |card|
  index, numbers = card.split(':')
  index = index.split(' ').last.to_i
  winning, yours = numbers.split('|').map(&:strip)

  winning = winning.split(' ')
  yours = yours.split(' ')

  wins = (winning & yours).size
  inputs.push(*wins.times.map { |i| inputs[index + i] })
end

puts "Day04::Part2: #{result2}"

