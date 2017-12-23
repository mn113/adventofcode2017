input = File.open("input.txt", "r")

# Extract lines information into an array
@instrs = []
input.each_line do |line|
	@instrs.push(line.split(" ").map{ |w| w =~ /\d+/ ? w.to_i : w })
end
p @instrs

@regs = Hash.new(0)
@regs['a'] = 1
@mul_count = 0
def proc_line(i)
	#p "line #{i}: #{@instrs[i]}"
	cmd, reg, val = @instrs[i]
	if !@regs.has_key?(reg) then @regs[reg] = 0 end
	if val =~ /\w+/ then val = @regs[val] end
	case cmd
		when 'set' then @regs[reg] = val
		when 'sub' then @regs[reg] -= val
		when 'mul' then @regs[reg] *= val; @mul_count += 1
		when 'jnz' then i += val - 1 if reg == 1 || @regs[reg] != 0
	end
	i += 1
end

i = 0
while i != 29 do
	i = proc_line(i)
	p @regs if @mul_count % 1000 == 0
end
