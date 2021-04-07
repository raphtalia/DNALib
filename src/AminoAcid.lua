local AminoAcid = {}
AminoAcid.__tostring = function(self)
    return self.Name
end

function AminoAcid.new(name, acronym)
    return setmetatable(
        {
            Name = name,
            Acronym = acronym
        },
        AminoAcid
    )
end

return AminoAcid