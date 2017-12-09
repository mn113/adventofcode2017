# Part 1:
input = File.open("../inputs/09input.txt", "r").each_line.first
input.gsub!(/!./, "")
	 .gsub!(/<([^>]*)>/, "")

input += '.'
total = 0
depth = 0
# Process char-by-char:
input.chars.each_with_index do |c,i|
	d = input.chars[i+1]
	depth += 1 if c == "{"
	total += depth if c == "}"
	depth -= 1 if c == "}" || d == "."
end
p total


# Part 2:
input = File.open("09input.txt", "r").each_line.first
input.gsub!(/!./, "")
	 .gsub!(/[^<^>]/, ".")

total = 0
in_garbage = false
# Process char-by-char:
input.chars.each do |c|
	if c == "<" && !in_garbage then in_garbage = true
	elsif c == ">" then in_garbage = false
	elsif in_garbage then total += 1 end
end
p total
