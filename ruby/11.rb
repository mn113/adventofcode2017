# Part 1:
input = File.open("../inputs/11input.txt", "r").each_line.first.split(",")

p axes = {
	'ne' => input.count('ne') - input.count('sw'),	# 368
	'nw' => input.count('nw') - input.count('se'),	# -94
	'n'  => input.count('n') - input.count('s')		# 307
}
# use equivalences to minimise total:
# 1ne + 1nw = 1n
# 1n  - 1nw = 1ne
while (axes['nw'] != 0) do
	axes['nw'] += 1
	axes['n']  -= 1
	axes['ne'] += 1
end
p axes, axes.values.reduce(:+)

# Part 2:
dist = max_dist = 0
axes = {'ne'=>0, 'nw'=>0, 'n'=>0}
input.each do |i|
	axes['nw'] += 1 if i == 'nw'
	axes['nw'] -= 1 if i == 'se'
	axes['ne'] += 1 if i == 'ne'
	axes['ne'] -= 1 if i == 'sw'
	axes['n'] += 1 if i == 'n'
	axes['n'] -= 1 if i == 's'
	dist = axes['ne'] + axes['n']
	max_dist = dist if dist > max_dist
end
p axes, max_dist
