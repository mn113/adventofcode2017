input = File.open("../inputs/08input.txt", "r")

registers = Hash.new

input.each_line do |line|
	# Match the register names using regex:
	/(?<key1>\w+) (inc|dec) \-?\d+ if (?<key2>\w+)/ =~  line.chomp

 	next if !key1 || !key2

	# Initialise any new register keys:
	registers[key1] = 0 if !registers.has_key?(key1)
	registers[key2] = 0 if !registers.has_key?(key2)

  	# Substitute += for inc, -= for dec, and wrap keys:
  	eval line.chomp
        	.gsub(/inc/, '+=')
        	.gsub(/dec/, '-=')
        	.gsub(/if/, '#')
        	.gsub(/([a-z]+)/, 'registers[\'\1\']')
        	.gsub(/#/, 'if')
end

# Part 1: Find max
p registers.values.max
