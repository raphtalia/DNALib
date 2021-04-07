local Converter = require(script.Parent.Converter)
local mRNA
local tRNA

local DNA = {}
DNA.__index = DNA
DNA.__tostring = function(self)
    return self.Sequence
end

function DNA.new(sequence)
    return setmetatable(
        {
            Sequence = sequence
        },
        DNA
    )
end

function DNA:tomRNA()
    if not mRNA then
        mRNA = require(script.Parent.mRNA)
    end
    return mRNA.new(Converter.convert("DNA", "mRNA", self.Sequence))
end

function DNA:totRNA()
    if not tRNA then
        tRNA = require(script.Parent.tRNA)
    end
    return tRNA.new(Converter.convert("DNA", "tRNA", self.Sequence))
end

function DNA:toAA()
    return Converter.convert("DNA", "AA", self.Sequence)
end

function DNA:split()
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

return DNA