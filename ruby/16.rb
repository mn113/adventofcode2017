dance = "abcdefghijklmnop".chars

# Extend built-in:
class Array
	# Array rotator
	def s!(num)
		self.rotate!(-num)
	end

	# Array swap pair by index
	def x!(i,j)
		self[i], self[j] = self[j], self[i]
		self
	end

	# Array swap pair by value
	def p!(a,b)
		i, j = self.find_index(a), self.find_index(b)
		self.x!(i,j)
	end
end

input = File.open("input.txt", "r")
# Process instructions:
instructions = input.each_line.first.split(",").map{ |s|
	head, tail = s.chr, s.slice!(1,5)
	if head == 's' then
		tail = [tail.to_i]
	else
		# Convert strings to integers if possible
		tail = tail.split("/")
		if head == 'x' then
			tail.map!{ |val| val.to_i }
		end
	end
	[head].concat(tail)
}

# Part 1: 1 times
# Part 2: 4e+9 times using memoization to identify period
results = [dance.join]

100.times do
	instructions.each do |inp|
		head, *tail = inp
		# Run command on dance (mutates it):
		dance.send(head+'!', *tail)
	end
	results.push(dance.join)
	# Check previous results:
	if dance.join == results[0] then
		break p "Result #{results.length} matches initial state"
	end
end
# Part 1:
p "Part 1: #{dance.join}"

# Part 2 period was 43
remainder = 1e+9.to_i % 42
p "Part 2: #{results[remainder]}"

p results
