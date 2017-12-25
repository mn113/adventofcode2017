@tape = Hash.new(0)
@i = 0
@state = 'A'

def step
	@state += @tape[@i].to_s	# concat e.g. A + 0
	case @state
	when 'A0' then @tape[@i] = 1; @i += 1; 'B'
	when 'A1' then @tape[@i] = 0; @i += 1; 'F'
	when 'B0' then @tape[@i] = 0; @i -= 1; 'B'
	when 'B1' then @tape[@i] = 1; @i -= 1; 'C'
	when 'C0' then @tape[@i] = 1; @i -= 1; 'D'
	when 'C1' then @tape[@i] = 0; @i += 1; 'C'
	when 'D0' then @tape[@i] = 1; @i -= 1; 'E'
	when 'D1' then @tape[@i] = 1; @i += 1; 'A'
	when 'E0' then @tape[@i] = 1; @i -= 1; 'F'
	when 'E1' then @tape[@i] = 0; @i -= 1; 'D'
	when 'F0' then @tape[@i] = 1; @i += 1; 'A'
	when 'F1' then @tape[@i] = 0; @i -= 1; 'E'
	end
end

12425180.times do
	@state = step()
end
p @tape.values().count(1)
