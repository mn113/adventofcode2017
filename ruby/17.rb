buf = [0]
step = 343
count = 1
pos = 0
goal = 2017

#Part 1
goal.times do
	pos = (pos + step) % count
	buf.insert(pos+1, count)
	pos += 1
	count += 1
end
p buf.slice(buf.find_index(goal)-2, 5)

# Part 2:
count = 1
pos = 0
50_000_000.times do
	pos = (pos + step) % count
	p count if pos == 0
	pos += 1
	count += 1
end
