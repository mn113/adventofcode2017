input1 = [187,254,0,81,169,219,1,190,19,102,255,56,46,32,2,216]
input2 = "187,254,0,81,169,219,1,190,19,102,255,56,46,32,2,216"

ring = (0..255).to_a
pos = 0
skip = 0
extra = [17,31,73,47,23]

input = input2.codepoints.concat(extra)	# ascii values incl. commas
p "input", input

64.times do
	input.each_with_index do |sub_length, i|
		#p "subl #{sub_length}"
		# Rotate backwards so we start at 0:
		ring = ring.rotate(pos)
		subsection = ring.slice(0, sub_length)
		#p "#{subsection} -> #{subsection.reverse}"
		# Replace with reversed subsection:
		ring = subsection.reverse.concat(ring.slice(sub_length, ring.size - sub_length))
		# Re-rotate:
		ring = ring.rotate(-pos)

		pos = (pos + sub_length + skip) % ring.size
		#p "pos #{pos}"
		skip += 1
		#p "skip #{skip}"
	end
end

# Part 1:
# p "Product:", ring.take(2).reduce(:*)

# Part 2:
sparse = ring
p "sparse", sparse
# Input is fully rearranged
# XOR groups of 16 to get dense hash of length 16:
dense = []
16.times do
	dense.push(sparse.slice!(0,16).reduce(:^))
end
p "dense", dense
p dense.map{ |n| n.to_s(16) }.join
