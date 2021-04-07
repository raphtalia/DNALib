# DNALib

Couldn't find any good converters for this so I wrote my own.

## Example

```lua
local DNALib = require(script.DNALib)

print(DNALib.new("TACGTTATGACT"):tomRNA():split())
print(DNALib.new("TACGTTATGACT"):toAA())

print(DNALib.new("TACACGACCTGCATC"):tomRNA():split())
print(DNALib.new("TACACGACCTGCATC"):toAA())
```

## Constructors

* DNALib.new(sequence: `string`)        -> `DNA`
* DNALib.frommRNA(sequence: `string`)   -> `DNA`
* DNALib.fromtRNA(sequence: `string`)   -> `DNA`

## Classes

* DNA
  * Sequence:   `string`
  * `tomRNA()`  -> `mRNA`
  * `totRNA()`  -> `tRNA`
  * `toAA()`    -> `AminoAcid[]`
  * `split()`   -> `string[]`
* mRNA
  * Sequence:   `string`
  * `toDNA()`   -> `DNA`
  * `totRNA()`  -> `tRNA`
  * `toAA()`    -> `AminoAcid[]`
  * `split()`   -> `string[]`
* tRNA
  * Sequence:   `string`
  * `toDNA()`   -> `DNA`
  * `tomRNA()`  -> `mRNA`
  * `toAA()`    -> `AminoAcid[]`
  * `split()`   -> `string[]`
* AminoAcid
  * Acronym:    `string`
