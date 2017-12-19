input = File.open("../inputs/19input.txt", "r")
@grid = input.each_line.map { |row| row.split("") }

# Find start:
@y = 0
@x = @grid[0].find_index("|")
@dir = "|"
@found = []
@steps = 0

# Move in a straight line until we hit '+'
def move_loop(vec)
	#p "Moving #{vec}..."
	while @grid[@y][@x] != "+" do
		@steps += 1
		c = @grid[@y][@x]
		if c =~ /[A-Z]/
			p "#{c} @ #{@steps}"
			raise StopIteration, @found.join if @found.include?(c)
			@found.push(c)
		end
		@x += vec[0]
		@y += vec[1]
	end
	#p "Turn at #{[@x,@y]}"
	turn
end

# Turn left or right, then move again
def turn
	@steps += 1
	if @dir == "|"
		[1,-1].each do |dx|
			if @grid[@y][@x+dx] =~ /[A-Z\-]/
				@dir = "-"
				@x += dx
				move_loop([dx,0])
			end
		end
	elsif @dir == "-"
		[1,-1].each do |dy|
			if @grid[@y+dy][@x] =~ /[A-Z|]/
				@dir = "|"
				@y += dy
				move_loop([0,dy])
			end
		end
	end
end

# Go!
move_loop([0,1])
