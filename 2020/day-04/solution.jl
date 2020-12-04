lines = read("input.txt", String)
passports = split(lines, "\n\n")

numvalid = 0
requiredfields = Set(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])

for passport in passports
    records = split(passport)
    fields = [record[1:3] for record in records]
    if issubset(requiredfields, fields)
        global numvalid += 1
    end
end

println(numvalid)

# ---

numvalid = 0
validecls = Set(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"])
validhclchars = Set("abcdef0123456789")

hgtmask = function (hgt)
    if hgt[end-1:end] == "cm"
        return 150 <= parse(Int, hgt[1:end-2]) <= 193
    elseif hgt[end-1:end] == "in"
        return 59 <= parse(Int, hgt[1:end-2]) <= 76
    else
        return false
    end
end

hclmask = function (hcl)
    return (
        (hcl[1] == '#') &
        (length(hcl[2:end]) == 6) &
        issubset(Set(hcl[2:end]), validhclchars)
    )
end

for passport in passports
    records = Dict(record[1:3] => record[5:end] for record in split(passport))
    if issubset(requiredfields, Set(keys(records)))
        if (
            (1920 <= parse(Int, records["byr"]) <= 2002) &
            (2010 <= parse(Int, records["iyr"]) <= 2020) &
            (2020 <= parse(Int, records["eyr"]) <= 2030) &
            hgtmask(records["hgt"]) &
            hclmask(records["hcl"]) &
            (records["ecl"] in validecls) &
            (length(records["pid"]) == 9)  # This doesn't check if it's numeric
        )
            global numvalid += 1
        end
    end
end

println(numvalid)
