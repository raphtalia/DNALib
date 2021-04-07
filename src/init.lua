local Converter = require(script.Converter)
local DNAClass = require(script.DNA)

local DNA = {}

function DNA.new(sequence)
    return DNAClass.new(sequence)
end

function DNA.frommRNA(sequence)
    return DNA.new(Converter.convert("mRNA", "DNA", sequence))
end

function DNA.fromtRNA(sequence)
    return DNA.new(Converter.convert("tRNA", "DNA", sequence))
end

return DNA