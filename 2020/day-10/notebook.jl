### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 072e0c76-3b1d-11eb-3988-11e176bca968
lines = readlines("input.txt")

# ╔═╡ 6e4d43f6-3b1e-11eb-1fb6-8397fc7000db
joltages = map(x -> parse(Int, x), lines)

# ╔═╡ 9ea5b88e-3b1f-11eb-3c9c-8500d58f0bfb
push!(joltages, 0)

# ╔═╡ a494fd14-3b1e-11eb-14d2-294d0cc103e2
push!(joltages, maximum(joltages) + 3)

# ╔═╡ de34a5a2-3b1d-11eb-222d-93a78defbd30
sortedjoltages = sort(joltages)

# ╔═╡ e970ad8e-3b1e-11eb-11c4-fdb707119f08
differences = diff(sortedjoltages)

# ╔═╡ f5b1e13a-3b1e-11eb-2025-2b10fca9763a
difference1 = count(x -> x == 1, differences)

# ╔═╡ 4e736ac8-3b1f-11eb-0dfd-433b985a7b5c
difference3 = count(x -> x == 3, differences)

# ╔═╡ 521e933c-3b1f-11eb-1f94-47f550e5da5f
difference1 * difference3

# ╔═╡ 5e8a1ae2-3b1f-11eb-3c1d-bd7905017043
# ---

# ╔═╡ 5b364c8a-3b1f-11eb-3497-7ff2bdf14000
solutions = Dict(0 => 1)

# ╔═╡ 089674f6-3b30-11eb-08ad-a9500af810c2
for joltage in sortedjoltages[2:end]
	global solutions[joltage] = 0
	for i in 1:3
		if joltage - i in keys(solutions)
			global solutions[joltage] += solutions[joltage - i]
		end
	end
end

# ╔═╡ b16b73a8-3b30-11eb-0665-ef314a760c55
solutions[maximum(sortedjoltages)]

# ╔═╡ Cell order:
# ╠═072e0c76-3b1d-11eb-3988-11e176bca968
# ╠═6e4d43f6-3b1e-11eb-1fb6-8397fc7000db
# ╠═9ea5b88e-3b1f-11eb-3c9c-8500d58f0bfb
# ╠═a494fd14-3b1e-11eb-14d2-294d0cc103e2
# ╠═de34a5a2-3b1d-11eb-222d-93a78defbd30
# ╠═e970ad8e-3b1e-11eb-11c4-fdb707119f08
# ╠═f5b1e13a-3b1e-11eb-2025-2b10fca9763a
# ╠═4e736ac8-3b1f-11eb-0dfd-433b985a7b5c
# ╠═521e933c-3b1f-11eb-1f94-47f550e5da5f
# ╠═5e8a1ae2-3b1f-11eb-3c1d-bd7905017043
# ╠═5b364c8a-3b1f-11eb-3497-7ff2bdf14000
# ╠═089674f6-3b30-11eb-08ad-a9500af810c2
# ╠═b16b73a8-3b30-11eb-0665-ef314a760c55
