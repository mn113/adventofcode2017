require 'set'

input = File.open("../inputs/04input.txt", "r") do |input|
	valid1 = 0
	valid2 = 0
	input.each_line do |line|
		words = line.split(" ")
		
		# Part 1
		valid1 += 1 if words.size == Set.new(words).size

		# Part 2 - sort each word's letters
		words2 = words.map!{ |w| w.codepoints.sort }
		valid2 += 1 if words2.size == Set.new(words2).size
	end

	p "Part 1: #{valid1}"
	p "Part 2: #{valid2}"
end
