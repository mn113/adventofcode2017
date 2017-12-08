input = File.open("../inputs/08input.txt", "r")

registers = Hash.new
max = 0

input.each_line do |line|
	# Match the register names using regex:
	/(?<key1>\w+) (inc|dec) \-?\d+ if (?<key2>\w+)/ =~  line.chomp

  next if !key1 || !key2

	# Initialise any new register keys:
	registers[key1] = 0 if !registers.has_key?(key1)
	registers[key2] = 0 if !registers.has_key?(key2)

  # Substitute += for inc, -= for dec:
  eval line.chomp
          .gsub(/inc/, '+=')
          .gsub(/dec/, '-=')
          .gsub(/if/, '#')
          .gsub(/([a-z]+)/, 'registers[\'\1\']')
          .gsub(/#/, 'if')

  high = registers.values.max
  max = high if high > max
end

p registers

# Part 1: Find max at end
p registers.values.max
# Part 2: Find greatest val from start to end:
p max
