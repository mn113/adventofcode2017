defmodule Day02 do
	@moduledoc """
	1. Sum (max - min) for each line of numbers
	2. Find unique factor/multiple pair on each line. Divide and sum.
	"""

	def get_input do
		File.read! "../inputs/02input.txt"
	end

	def solve do
		lines = get_input()
		|> String.split("\n", trim: true)
		|> Enum.map(fn line ->
			line
			|> String.split("\t")
			|> Enum.map(&String.to_integer/1)
		end)

		# Part 1:
		lines
		|> Enum.map(&diff_max_min/1)
		|> Enum.sum
		|> IO.puts

		# Part 2:
		lines
		|> Enum.map(&find_factors/1)
		|> Enum.map(fn {a,b} -> div(a,b) end)
		|> Enum.sum
		|> IO.puts
	end

	def diff_max_min(nums) do
		minmax = nums
		|> Enum.min_max
		|> Tuple.to_list

		List.last(minmax) - List.first(minmax)
	end

	def find_factors(nums) do
		nums
		|> Enum.sort
		|> Enum.map(fn i ->
			nums
			|> Enum.sort
			|> Enum.reverse
			|> Enum.map(fn j ->
				if(j != i and rem(j,i) == 0, do: {j,i}, else: nil)
			end)
			|> Enum.reject(&is_nil/1)	# reject nils
		end)
		|> Enum.reject(&Enum.empty?/1)	# reject empties
		|> Enum.at(0)	# in theory only one combo exists
		|> Enum.at(0)
	end
end

Day02.solve()
