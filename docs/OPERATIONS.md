# Functional behavior of the uploaded RTL

This file describes the actual branches in `rtl/Converter.v` (original, preserved unchanged) and the decoder in `rtl/seven_Seg.v`.

## Inputs and outputs

| Name | Width | Meaning |
|---|---:|---|
| `S` | 3 | Operation selection, 000–111 |
| `G` | 3 | First unsigned operand, 0–7 (marked °C in source comments) |
| `Y` | 3 | Second unsigned operand, 0–7 (marked °C in source comments) |
| `Led` | 4 | BCD-like digit/symbol selector for the display module |
| `Overflow_Flag` | 1 | Indicates certain out-of-range/placeholder modes |
| `BCD_Output` | 7 | **Active-low** seven-segment bus, despite `BCD_` name |

## Operations (`S`)

- `000`: Sets `Led = 0`, `Overflow_Flag = 1`. Comment calls this `G → Fahrenheit`. No Celsius-to-Fahrenheit arithmetic is performed.
- `001`: Identical output behavior; comment refers to `Y → Fahrenheit`.
- `010`: Compares `G == Y`. Equal: `Led = 6`, decoded specially to letter **E**. Unequal: `Led = 9`, decoded specially to **U**, and flag cleared. **Bug:** no flag assignment when equal.
- `011`: If `(G + 4) > 9`, set `Led = 0`, flag `1`; otherwise `Led = G + 4`, flag `0`. The source uses bit-level assignments to implement the no-overflow case.
- `100`: `Led = {1'b0, ~Y[2:0]}` — equivalent to `7 - Y` for the three-bit unsigned operand.
- `101`: `Led = {1'b0, G[2:0]}` — equals `G AND 3'b111`.
- `110`: `Led = 7` — same as `~(G AND 3'b000)` for the three-bit operand.
- `111`: `Led = 15`, flag `0`. The decoder outputs all ones, so the display is blank if active-low.

## Special character / seven-segment decoder

`seven_Seg.v` decodes `Led` to active-low patterns for `0` through `9`. In comparison mode (`S=010`): `Led=6` displays **E** (`0000110`), and `Led=9` displays **U** (`1000001`). `Led=15` yields `1111111` (off). Values `10`–`14` fall back to pattern `1000000`.

The original display code does **not** document segment pin bit order (`a`–`g`), so verify against your board's wiring and documentation.
