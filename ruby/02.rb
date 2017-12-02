input = File.open("../inputs/02input.txt", "r") do |input|
	sumA = 0
	sumB = 0
	input.each_line do |line|
		vals = line.split("\t").map{|s| s.to_i}
		# Part 1:
		sumA += vals.max - vals.min

		# Part 2:
		# Search from opposite ends to quickly find the unique factor i of j
		vals.sort!
		vals.each do |i|
			break if 'found' == vals.reverse.each do |j|
				if j != i && j % i == 0 then
					sumB += j / i
					break 'found'	# breaks out of 2x each
				end
			end
		end
	end
	p 'Part 1:', sumA
	p 'Part 2:', sumB
end
