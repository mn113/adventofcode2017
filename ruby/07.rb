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

input = File.open("input.txt", "r")

@tops = []
@meds = []
@bots = []
@weights = {}
@links = {}
@full_weights = {}
@depths = Hash.new(0)

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
p 'weights', @weights.size
p 'links', @links.size

# Isolate the categories:
@bots.delete_if { |t| @meds.include?(t) }
@meds.delete_if { |t| @bots.include?(t) || @tops.include?(t) }
# Part 1:
p 'bottom', @bots.size, @bots
p 'meds', @meds.size
p 'tops', @tops.size

# Part 2:
# Recursive function to sum full chains of links:
def fully_weigh_node(key, depth)
	@depths[key] = depth
	if @tops.include?(key)
		@full_weights[key] = @weights[key]	# end of chain
	else
		@full_weights[key] = @weights[key] + @links[key].map{ |n| fully_weigh_node(n, depth+1) }.reduce(:+)
	end
end

fully_weigh_node(@bots[0], 0)
#p @full_weights

# Hard-code finding the odd one out:
p @links[@bots[0]].map { |key| {key => @full_weights[key]} }
p @links['jjjks'].map { |key| {key => @full_weights[key]} }
p @links['gtervu'].map { |key| {key => @full_weights[key]} }
p @links['ycbgx'].map { |key| {key => @full_weights[key]} }	# 243, 243, 243
p @weights['ycbgx']
