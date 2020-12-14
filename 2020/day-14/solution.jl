function binary36bits(s)
    bitstring(parse(Int, s))[29:end]  # Only 36 bits
end


lines = readlines("input.txt")

memory = Dict()
mask = repeat("X", 36)
regex = r"mem\[(\d*)\] = (\d*)"

for line in lines
    global memory, mask, regex
    if startswith(line, "mask")
        mask = line[8:end]
    elseif startswith(line, "mem")
        address, value = match(regex, line).captures
        address = parse(Int, address)
        value = binary36bits(value)
        maskedvalue =
            parse(Int, join([m == 'X' ? v : m for (m, v) in zip(mask, value)]), base = 2)
        memory[address] = maskedvalue
    end
end

memory |> values |> sum |> println

# ---

function addresses(maskedaddress)
    addresses = [maskedaddress]
    while occursin('X', addresses[1])
        address = popfirst!(addresses)
        push!(addresses, replace(address, 'X' => '0', count = 1))
        push!(addresses, replace(address, 'X' => '1', count = 1))
    end
    map(x -> parse(Int, x, base = 2), addresses)
end


memory = Dict()
mask = repeat("X", 36)
regex = r"mem\[(\d*)\] = (\d*)"

for line in lines
    global memory, mask, regex
    if startswith(line, "mask")
        mask = line[8:end]
    elseif startswith(line, "mem")
        address, value = match(regex, line).captures
        address = binary36bits(address)
        value = parse(Int, value)
        maskedaddress = join([m == '0' ? a : m for (m, a) in zip(mask, address)])
        addresses_ = addresses(maskedaddress)
        for address in addresses_
            memory[address] = value
        end
    end
end

memory |> values |> sum |> println
