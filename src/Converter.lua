local AminoAcid = require(script.Parent.AminoAcid)

local Mappings = {
    DNA 	= "TAGC",
	mRNA	= "AUCG",
	tRNA	= "UAGC",

    AminoAcids = {
        DNA = {},
        mRNA = {
            UUU = {"Phenylalanine", "Phe"},
            UUC = {"Phenylalanine", "Phe"},
            UUA = {"Leucine",       "Leu"},
            UUG = {"Leucine",       "Leu"},

            UCU = {"Serine",        "Ser"},
            UCC = {"Serine",        "Ser"},
            UCA = {"Serine",        "Ser"},
            UCG = {"Serine",        "Ser"},

            UAU = {"Tyrosine",      "Tyr"},
            UAC = {"Tyrosine",      "Tyr"},
            UAA = {"Terminator",    "Ter"},
            UAG = {"Terminator",    "Ter"},

            UGU = {"Cysteine",      "Cys"},
            UGC = {"Cysteine",      "Cys"},
            UGA = {"Terminator",    "Ter"},
            UGG = {"Tryptophan",    "Trp"},

            CUU = {"Leucine",       "Leu"},
            CUC = {"Leucine",       "Leu"},
            CUA = {"Leucine",       "Leu"},
            CUG = {"Leucine",       "Leu"},

            CCU = {"Proline",       "Pro"},
            CCC = {"Proline",       "Pro"},
            CCA = {"Proline",       "Pro"},
            CCG = {"Proline",       "Pro"},

            CAU = {"Histidine",     "His"},
            CAC = {"Histidine",     "His"},
            CAA = {"Glutamine",     "Gln"},
            CAG = {"Glutamine",     "Gln"},

            CGU = {"Arginine",      "Arg"},
            CGC = {"Arginine",      "Arg"},
            CGA = {"Arginine",      "Arg"},
            CGG = {"Arginine",      "Arg"},

            AUU = {"Isoleucine",    "Ile"},
            AUC = {"Isoleucine",    "Ile"},
            AUA = {"Isoleucine",    "Ile"},
            AUG = {"Methionine",    "Met"},

            ACU = {"Threonine",     "Thr"},
            ACC = {"Threonine",     "Thr"},
            ACA = {"Threonine",     "Thr"},
            ACG = {"Threonine",     "Thr"},

            AAU = {"Asparagine",    "Asn"},
            AAC = {"Asparagine",    "Asn"},
            AAA = {"Lysine",        "Lys"},
            AAG = {"Lysine",        "Lys"},

            AGU = {"Serine",        "Ser"},
            AGC = {"Serine",        "Ser"},
            AGA = {"Arginine",      "Arg"},
            AGG = {"Arginine",      "Arg"},

            GUU = {"Valine",        "Val"},
            GUC = {"Valine",        "Val"},
            GUA = {"Valine",        "Val"},
            GUG = {"Valine",        "Val"},

            GCU = {"Alanine",       "Ala"},
            GCC = {"Alanine",       "Ala"},
            GCA = {"Alanine",       "Ala"},
            GCG = {"Alanine",       "Ala"},

            GAU = {"Aspartic Acid", "Asp"},
            GAC = {"Aspartic Acid", "Asp"},
            GAA = {"Glutamic Acid", "Glu"},
            GAG = {"Glutamic Acid", "Glu"},

            GGU = {"Glycine",       "Gly"},
            GGC = {"Glycine",       "Gly"},
            GGA = {"Glycine",       "Gly"},
            GGG = {"Glycine",       "Gly"}
        },
        tRNA = {}
    }
}

local Converter = {}

function Converter.convert(startEncoding, endEncoding, sequence)
    assert(Mappings[startEncoding] and startEncoding ~= "AminoAcids", "Expected DNA, mRNA, or tRNA as Argument #1")
    assert((Mappings[startEncoding] and startEncoding ~= "AminoAcids") or endEncoding == "AA", "Expected DNA, mRNA, tRNA, or AA as Argument #2")
    assert(type(sequence) == "string", "Expected sequence to be a string")

    sequence = sequence:upper()
    local convertedSequence

    if endEncoding == "AA" then
        assert(#sequence % 3 == 0, "Expected sequence to be divisible by 3")

        convertedSequence = {}
        for i = 0, #sequence, 3 do
            local codon = sequence:sub(i + 1, i + 3)
            table.insert(convertedSequence, Mappings.AminoAcids[startEncoding][codon])
        end
    else
        convertedSequence = ""

        for i = 1, #sequence do
            local mappingPos = Mappings[startEncoding]:find(sequence:sub(i, i))
            convertedSequence ..= Mappings[endEncoding]:sub(mappingPos, mappingPos)
        end
    end

    return convertedSequence
end

for encoding, aminoAcid in pairs(Mappings.AminoAcids.mRNA) do
    aminoAcid = AminoAcid.new(aminoAcid[1], aminoAcid[2])

    Mappings.AminoAcids.DNA[Converter.convert("mRNA", "DNA", encoding)] = aminoAcid
    Mappings.AminoAcids.mRNA[encoding] = aminoAcid
    Mappings.AminoAcids.tRNA[Converter.convert("mRNA", "tRNA", encoding)] = aminoAcid
end

return Converter