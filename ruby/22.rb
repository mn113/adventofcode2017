grid = File.open("../inputs/22input.txt", "r").map { |row| row.chomp }

nesw = [[-1,0], [0,1], [1,0], [0,-1]] # [y,x]
dir = 0 # index for nesw
x = y = 12
count = 0

def increase_bounds(grid)
	width = grid[0].length
	# Add an empty row at start and end:
	grid.unshift('.' * width)
	grid.push('.' * width)
	# Add an empty column at start and end:
	grid.map! { |row| '.' + row + '.' }
	grid
end

p grid
p "#{grid.size} x #{grid[0].length}"

10_000_000.times do |i|
	# Turn R if infected, L if clean, reverse if flagged:
	case grid[y][x]
	when '#' then dir = (dir + 1) % 4; treated = 'F'
	when '.' then dir = (dir - 1) % 4; treated = 'W'
	when 'F' then dir = (dir + 2) % 4; treated = '.'
	when 'W' then treated = '#'
	end

	# (Un)infect current node:
	grid[y][x] = treated
	count += 1 if treated == '#'

	# Increase bounds?
	if x == 0 || y == 0 || x == grid.size - 1 || y == grid.size - 1
		grid = increase_bounds(grid)
		# Put cursor back where it should be:
		y += 1
		x += 1
		#p "size #{grid.size} x #{grid[0].length}"
	end

	# Advance:
	y += nesw[dir][0]
	x += nesw[dir][1]

	#p grid
	#p "@ #{[y,x]}"
	p "#{i} #{count}" if i % 1_000_000 == 0
end

p "#{count} infections occurred"
