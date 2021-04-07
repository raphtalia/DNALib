local Converter = require(script.Parent.Converter)
local DNA
local mRNA

local tRNA = {}
tRNA.__index = tRNA
tRNA.__tostring = function(self)
    return self.Sequence
end

function tRNA.new(sequence)
    return setmetatable(
        {
            Sequence = sequence
        },
        tRNA
    )
end

function tRNA:toDNA()
    if not DNA then
        DNA = require(script.Parent.DNA)
    end
    return DNA.new(Converter.convert("tRNA", "DNA", self.Sequence))
end

function tRNA:tomRNA()
    if not mRNA then
        mRNA = require(script.Parent.mRNA)
    end
    return mRNA.new(Converter.convert("tRNA", "mRNA", self.Sequence))
end

function tRNA:toAA()
    return Converter.convert("tRNA", "AA", self.Sequence)
end

function tRNA:split()
    local splitSequence = {}
    local sequence = self.Sequence
    local sequenceLength = #sequence

    for i = 0, math.ceil(#sequence/3)*3, 3 do
        if i < sequenceLength then
            table.insert(splitSequence, sequence:sub(i + 1, i + 3))
        end
    end

    return splitSequence
end

return tRNA