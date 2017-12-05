$instr_list = File.open("../inputs/05input.txt", "r").each_line.map(&:to_i)

def jump(pos)
	instr = $instr_list[pos]
	$instr_list[pos] -= 2 if instr >= 3	# enable this line for Part 2 only
	$instr_list[pos] += 1
	pos += instr
end

# Parts 1 & 2
n = 0
pos = 0
while pos >= 0 && pos < $instr_list.length do
	pos = jump(pos)
	n += 1
end
puts [n, pos].join(' ')
