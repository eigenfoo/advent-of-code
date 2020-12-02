lines = readlines("input.txt")
masses = map(x -> parse(Float64, x), lines)

total_fuel_requirement = 0

for i = 1:size(masses)[1]
    fuel_requirement = floor(masses[i] / 3) - 2

    while fuel_requirement > 0
        global total_fuel_requirement += fuel_requirement
        fuel_requirement = floor(fuel_requirement / 3) - 2
    end
end

total_fuel_requirement = convert(Int64, total_fuel_requirement)
println(total_fuel_requirement)
