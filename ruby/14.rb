def knot_hash(input_str)
	ring = (0..255).to_a
	pos = 0
	skip = 0
	extra = [17,31,73,47,23]

	#p input_str
	input = input_str.codepoints.concat(extra)

	64.times do
		# Flip a ring section for every input value:
		input.each_with_index do |sub_length, i|
			# Rotate backwards so we start at 0:
			ring = ring.rotate(pos)
			subsection = ring.slice(0, sub_length)
			# Replace with reversed subsection:
			ring = subsection.reverse.concat(ring.slice(sub_length, ring.size - sub_length	))
			# Re-rotate:
			ring = ring.rotate(-pos)

			pos = (pos + sub_length + skip) % ring.size
			skip += 1
		end
	end

	sparse = ring
	# Input is fully rearranged
	# XOR groups of 16 to get dense hash of length 16:
	dense = []
	16.times do
		dense.push(sparse.slice!(0,16).reduce(:^).to_s(16).rjust(2,'0'))
	end

	p dense.join
end


# Day 14 Part 1:
@grid = [];
128.times do |i|
	@grid.push(knot_hash("hwlqcszp-"+i.to_s).chars.map{ |n| n.hex.to_s(2).rjust(4,'0') }.join.chars.map(&:to_i))
end
p @grid
p @grid.map{ |row| row.count(1) }.reduce(:+)

def setNeighbs(x,y,val)
	nb = [[x+1,y],[x-1,y],[x,y+1],[x,y-1]]
	nb.each do |(x,y)|
		# Pass if out-of-bounds:
		next if x < 0 || y < 0 || x > 127 || y > 127
		# Pass if empty cell:
		next if @grid[y][x] == 0
		# Fill & propagate if 1-cell:
		if @grid[y][x] == 1 then
			@grid[y][x] = val
			setNeighbs(x,y,val)
		end
	end
end

# Part 2
@uuid = 1
@grid.each_with_index do |row,y|
	row.each_with_index do |val,x|
		next if val == 0
		if val == 1 then
			@uuid += 1
			val = @uuid
			# Propagate to 4 neighbs, and so on recursively:
			setNeighbs(x,y,val)
		end
	end
end

p @grid
p @uuid
