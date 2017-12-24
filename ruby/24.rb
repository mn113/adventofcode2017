@pairs = File.open("input.txt", "r").map { |row| row.split("/").map(&:to_i) }
#@pairs = [ [0,1],[0,2],[1,10],[2,2],[2,3],[3,4],[3,5],[9,10] ]
#p @pairs

@highest = 1250
@longest = 30

def add_component(port, tally = 0, chain = [[0]], pairs = @pairs)
	#p "add_component(#{port}, #{tally}, #{chain.size}, #{pairs.size})"

	# Prioritise adding a double:
	double = [port,port]
	if pairs.include?(double)
		tally += double.reduce(:+)
		chain.push(double)
		pairs.delete(double)
		add_component(port, tally, chain, pairs)
	else
		matches = pairs.reject{ |i| chain.include?(i) || !i.include?(port) }

		for m in matches do
			new_port = m.reduce(:+) - port

			new_tally = tally + m.reduce(:+)
			if new_tally > @highest
				@highest = new_tally
				p "hi: #{new_tally}"
			end

			new_chain = chain.dup
			new_chain.push(m)
			if new_chain.size >= @longest
				@longest = new_chain.size
				p "chain of #{new_chain.size} scores #{new_tally}"
			end

			new_pairs = pairs.dup
			new_pairs.delete(m)

			add_component(new_port, new_tally, new_chain, new_pairs)
		end
	end
end

add_component(0)
