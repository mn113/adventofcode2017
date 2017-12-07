input = """
pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)
"""

input = File.open("07input.txt", "r")

@tops = []
@meds = []
@bots = []
@weights = {}
@links = {}

input.each_line do |line|
	# Match the parts using regex:
	/(?<lhs>\w+) \((?<wt>\d+)\)( -> (?<rhs>[\w\s,]+))?/ =~ line.chomp

	@tops.push(lhs) if lhs && !rhs		# Definitely a top / a loner
	@meds.concat(rhs.split(', ')) if rhs	# Definitely a mid or top
	@bots.push(lhs) if lhs && rhs		# Could be a mid, or a bottom
	@weights[lhs] = wt.to_i if wt
	# Use {term => weight} hash as key:
	@links[lhs] = rhs.split(', ') if rhs
end
p 'weights', @weights
p 'links', @links

# Isolate the categories:
@bots.delete_if { |t| @meds.include?(t) }
@meds.delete_if { |t| @bots.include?(t) || @tops.include?(t) }
# Part 1:
p 'bottom', @bots
p 'meds', @meds
#p tops

# Part 2:
# Recursive function to sum full chains of links:
def fully_weigh_node(key)
	return @weights[key] if @tops.include?(key)

	@weights[key] + @links[key].map{ |n| fully_weigh_node(n) }.reduce(:+)
end

#p fully_weigh_node('fwft')

@links.each_key do |node|
	# Parent weight + children weight
	# Must be equal for all rhs sets
	p "#{node} -> #{fully_weigh_node(node)}"
end
