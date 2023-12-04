#!/usr/bin/ruby
require 'matrix'

inputs = File.readlines('inputs/03.txt', chomp: true).map(&:chars)
# inputs = <<-STRING
# 467..114..
# ...*......
# ..35..633.
# ......#...
# 617*......
# .....+.58.
# ..592.....
# ......755.
# ...$.*....
# .664.598..
# STRING
# inputs = inputs.split("\n").map(&:chars)

matrix = Matrix[*inputs]

result1 = 0
number = 0
adjacent = false

matrix.each_with_index do |value, row, col|
  value = value.to_i if value.match?(/\d/)

  if value.is_a?(Integer)
    number = number * 10 + value

    [-1, 0, 1].each do |i|
      [-1, 0, 1].each do |j|
        adj = matrix[row + i, col + j]
        next if adj.nil? || adj.match?(/\d/) || adj == '.'

        adjacent = !!adj.scan(/[\D\W]/)[0]
      end
    end
  elsif adjacent
    result1 += number
    number = 0
    adjacent = false
  else
    number = 0
  end
end

puts "Day03::Part1: #{result1}"

# ====================================================

result2 = Hash.new { |h, k| h[k] = [] }
number = 0
adjacent = false
gears = []

matrix.each_with_index do |value, row, col|
  value = value.to_i if value.match?(/\d/)

  if value.is_a?(Integer)
    number = number * 10 + value

    [-1, 0, 1].each do |i|
      [-1, 0, 1].each do |j|
        adj = matrix[row + i, col + j]
        next if adj.nil? || adj.match?(/\d/) || adj == '.'

        adjacent = !!adj.scan(/[\D\W]/)[0]
        gears << [row + i, col + j] if adj.scan(/[\D\W]/)[0] == '*'
      end
    end
  elsif adjacent
    gears.each { |gear| result2[gear] |= [number] }

    number = 0
    adjacent = false
    gears = []
  else
    number = 0
  end
end

result2 = result2.sum { |_, v| v.size == 2 ? v.inject(:*) : 0 }

puts "Day03::Part2: #{result2}"
