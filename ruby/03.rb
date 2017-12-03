neighbs = [[0,1], [1,0], [0,-1], [-1,0], [1,1], [-1,-1], [1,-1], [-1,1]]
compass = [[0,1], [1,0], [0,-1], [-1,0]]	# S,E,N,W
i = 0	# compass index
grid = []
limit = 11	# max grid size (odd) - increase if IndexError before solution

#Class Grid

# zero-fill grid, 1 at centre:
grid = Array.new(limit) { Array.new(limit) {0} }
curPos = [(limit-1)/2, (limit-1)/2]	# centre
grid[curPos[0]][curPos[1]] = 1
p grid

#grid helpers
def getVal(grid, coords)
	grid[coords[0]][coords[1]]
end
def setVal(grid, coords, val)
	grid[coords[0]][coords[1]] = val
end
# vector addition
def add(ptA, ptB)
	[ptA[0]+ptB[0], ptA[1]+ptB[1]]
end

# commence filling grid:
while true do
	# turn CCW every go:
	i = (i+1) % 4
	# turn CW if blocked:
	if getVal(grid, add(curPos, compass[i])) > 0 then
		i = (i-1) % 4
		nextPos = add(curPos, compass[i])
	end

	p [curPos, "=", getVal(grid, curPos)]	# val should always be 0

	# sum the 8 neighbours:
	sum_of_8 = 0
	neighbs.each do |nb|
		sum_of_8 += getVal(grid, add(curPos, nb))
	end
	p sum_of_8

	# update grid:
	setVal(grid, curPos, sum_of_8)
	break if sum_of_8 > 277678
end
