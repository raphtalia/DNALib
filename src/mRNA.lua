local Converter = require(script.Parent.Converter)
local DNA
local tRNA

local mRNA = {}
mRNA.__index = mRNA
mRNA.__tostring = function(self)
    return self.Sequence
end

function mRNA.new(sequence)
    return setmetatable(
        {
            Sequence = sequence
        },
        mRNA
    )
end

function mRNA:toDNA()
    if not DNA then
        DNA = require(script.Parent.DNA)
    end
    return DNA.new(Converter.convert("mRNA", "DNA", self.Sequence))
end

function mRNA:totRNA()
    if not tRNA then
        tRNA = require(script.Parent.tRNA)
    end
    return tRNA.new(Converter.convert("mRNA", "mRNA", self.Sequence))
end

function mRNA:toAA()
    return Converter.convert("mRNA", "AA", self.Sequence)
end

function mRNA:split()
    local splitSequence = {}
    local sequence = self.Sequence
    local sequenceLength = #sequence

    for i = 0, math.ceil(sequenceLength/3)*3, 3 do
        if i < sequenceLength then
            table.insert(splitSequence, sequence:sub(i + 1, i + 3))
        end
    end

    return splitSequence
end

return mRNA