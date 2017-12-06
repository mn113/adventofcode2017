require 'set'

mem = "4	1	15	12	0	9	9	5	5	8	7	3	14	5	12	3".split.map(&:to_i)
history = [mem.clone.to_s]
history_set = Set.new([mem.clone.to_s])

# Find the first maximal element
def index_of_max(mem)
	mem.index(mem.max)
end

# Take the largest integer amount in the array and redistribute it between all columns
def redistribute(mem)
	index = index_of_max(mem)
	len = mem.length
	pos = (index + 1) % len
	mem[index].times do
		# Increment, decrement source, move along 1:
		mem[pos] += 1
		mem[index] -= 1
		pos = (pos + 1) % len
	end
	mem
end

rounds = 0
# Iterate until history array exceeds history set:
while history.length == history_set.length do
	rounds += 1
	new_state = redistribute(mem).clone.to_s
	history.push(new_state)
	history_set.add(new_state)
end

p "Part 1: #{rounds}"
diff = history.rindex(new_state) - history.index(new_state)
p "Part 2: #{diff}"
