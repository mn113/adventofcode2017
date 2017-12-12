input = File.open("../inputs/12input.txt", "r")

# Extract lines information into a Hash:
@links = Hash.new
input.each_line do |line|
	/(?<lhs>\d+) <-> (?<rhs>[\d\s,]+)/ =~  line.chomp
	if lhs && rhs then
		@links[lhs.to_i] = rhs.split(", ").map(&:to_i).sort()
	end
end

# Get the group of numbers for a given key:
def follow_links(nums)
	nums.map{ |n| @links[n] }.flatten.uniq
end

# Repeatedly search for one key's extra group members, until group's size is stable:
def build_group(key)
	group = [key]
	last_size = 0
	until group.size == last_size do
		last_size = group.size
		group.concat(follow_links(group)).uniq!
	end
	# Clean up @links by deleting used keys:
	group.each { |i| @links.delete(i) if i > key }
	p "key #{key}, group size = #{group.size}"
	group.sort
end

# Part 1:
@links[0] = build_group(0)

# Part 2:
# Build ALL possible groups, starting low, skipping any missing keys:
key = 1
while key < @links.keys.max do
	@links[key] = build_group(key) if @links[key]
	key += 1
end
p "#{@links.size} distinct groups"
