neighbs = [[0,1], [1,0], [0,-1], [-1,0], [1,1], [-1,-1], [1,-1], [-1,1]]
compass = [[0,1], [1,0], [0,-1], [-1,0]]	# S,E,N,W
i = 0	# compass index
limit = 11	# max grid size (odd) - increase if IndexError before solution

class Grid
	def initialize(data)
		@data = data
	end

	def getVal(coords)
		self.data[coords[0]][coords[1]]
	end

	def setVal(coords, val)
		self.data[coords[0]][coords[1]] = val
	end

	attr_accessor :data		# makes data attribute readable/writable
end

# zero-fill grid, 1 at centre:
grid = Grid.new(Array.new(limit) { Array.new(limit) {0} })
curPos = [(limit-1)/2, (limit-1)/2]	# centre
grid.setVal(curPos, 1)

# vector addition
def add(ptA, ptB)
	[ptA[0]+ptB[0], ptA[1]+ptB[1]]
end

# commence filling grid:
while true do
	# turn CCW every go:
	i = (i+1) % 4
	# turn CW if blocked:
	if grid.getVal(add(curPos, compass[i])) > 0 then
		i = (i-1) % 4
	end
	curPos = add(curPos, compass[i])

	# sum the 8 neighbours:
	sum_of_8 = 0
	neighbs.each do |nb|
		sum_of_8 += grid.getVal(add(curPos, nb))
	end
	p sum_of_8

	# update grid:
	grid.setVal(curPos, sum_of_8)
	break if sum_of_8 > 277678
end
