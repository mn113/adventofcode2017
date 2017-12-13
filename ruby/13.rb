input = File.open("../inputs/13input.txt", "r")

# Extract lines information into a Hash:
@firewall_layers = Hash.new
input.each_line do |line|
	/(?<lhs>\d+): (?<rhs>\d+)/ =~  line.chomp
	if lhs && rhs then
		@firewall_layers[lhs.to_i] = rhs.to_i
	end
end

# Try passing through firewall layers at index 0, and count detections:
def firewall_traversal_cost(delay)
	detections = []
	@firewall_layers.each_pair do |layer, scan_range|
		# Calculate when this layer's scanner will return to position zero:
		time = layer + delay
		period = (scan_range - 1) * 2
		if time % period == 0 then detections.push(layer * scan_range) end
	end
	p detections
	if detections.empty? then 0 else detections.reduce(0.001, :+) end
end

# Part 1:
p "Cost with 0 delay: #{firewall_traversal_cost(0)}"

# Part 2:
# Sieving an input range:
@delays = (0..4000000).to_a
@firewall_layers.each_pair do |layer, scan_range|
	# Calculate when this layer's scanner will return to position zero:
	period = (scan_range - 1) * 2
	offset = layer
	# Reject all delays which this scanner will catch:
	@delays.reject!{ |d| (d + offset) % period == 0 }
	p "valid delays: #{@delays.size}"
	break if @delays.size == 0
end
p @delays

@delays.each do |d|
	p "Cost with #{d} delay: #{firewall_traversal_cost(d)}"
end
