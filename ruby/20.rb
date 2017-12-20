input = File.open("input.txt", "r")
particles = input.each_line.map do |line|
	/^p=<(?<px>-?\d+),(?<py>-?\d+),(?<pz>-?\d+)>,\s
	  v=<(?<vx>-?\d+),(?<vy>-?\d+),(?<vz>-?\d+)>,\s
	  a=<(?<ax>-?\d+),(?<ay>-?\d+),(?<az>-?\d+)>/x =~ line.chomp

	{:p => [px,py,pz].map(&:to_i),
	 :v => [vx,vy,vz].map(&:to_i),
	 :a => [ax,ay,az].map(&:to_i)}
end

p "#{particles.size} particles loaded"

t = 0
until t == 40 do
	particles.each do |part|
		next if part.nil?

		# Adjust velocities:
		part[:v][0] += part[:a][0]
		part[:v][1] += part[:a][1]
		part[:v][2] += part[:a][2]
		# Adjust positions:
		part[:p][0] += part[:v][0]
		part[:p][1] += part[:v][1]
		part[:p][2] += part[:v][2]
	end

	# Part 1: closest particle to [0,0,0] over time:
	# (Requires 1000 iterations)
	dists = particles.map { |part| part[:p].map(&:abs).reduce(:+) }
	p dists.each_with_index.min   # 144

	# Part 2: remove colliders:
	(0..particles.size-1).each do |i|
		next if particles[i].nil?
		pos = particles[i][:p].dup
		(i+1..particles.size-1).each do |j|
			next if particles[j].nil?
			if pos == particles[j][:p]
				p "collision! #{i} #{j}"
				particles[i] = nil
				particles[j] = nil
			end
		end
	end

	t += 1
	p "#{particles.reject{ |part| part.nil? }.size} particles remain at t #{t}"
end
