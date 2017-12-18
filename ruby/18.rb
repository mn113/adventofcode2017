input = File.open("../inputs/18input.txt", "r")

# Extract lines information into an array
@instrs = []
input.each_line do |line|
	@instrs.push(line.split(" ").map{ |w| w =~ /\d+/ ? w.to_i : w })
end
p @instrs

@regs = {}
@output = []
def proc_line(i)
	p "line #{i}"
	cmd, reg, val = @instrs[i]
	if !@regs.has_key?(reg) then @regs[reg] = 0 end
	if val =~ /\w+/ then val = @regs[val] end
	case cmd
		when 'set' then @regs[reg] = val
		when 'add' then @regs[reg] += val
		when 'mul' then @regs[reg] *= val
		when 'mod' then @regs[reg] = @regs[reg] % val
		when 'snd' then @output.push(@regs[reg])
		when 'rcv' then return 0 if @regs[reg] != 0
		when 'jgz' then i += val - 1 if @regs[reg] > 0
	end
	p @regs
	i += 1
	proc_line(i)
end

proc_line(0)
p @output
