a = 873
b = 583
@a_mult = 16807
@b_mult = 48271
@divisor = 2147483647
matches = 0

def next_a(n)
	n * @a_mult % @divisor
end

def next_b(n)
	n * @b_mult % @divisor
end

def binary_tail(n)
	n % 65536	# == 2**16
end

# Part 1:
4e+7.to_i.times do
	a = next_a(a)
	b = next_b(b)
	matches += 1 if binary_tail(a) == binary_tail(b)
end
p "#{matches} matches"

# Part 2:
# Reset:
a = 873
b = 583
a_list = []
b_list = []
matches = 0

until a_list.size == 5e+6 do
	a = next_a(a)
	a_list.push(binary_tail(a)) if a % 4 == 0
end

until b_list.size == 5e+6 do
	b = next_b(b)
	b_list.push(binary_tail(b)) if b % 8 == 0
end

# Compare 5 million of each category:
5e+6.to_i.times do
	matches += 1 if a_list.pop == b_list.pop
end
p "#{matches} matches"
