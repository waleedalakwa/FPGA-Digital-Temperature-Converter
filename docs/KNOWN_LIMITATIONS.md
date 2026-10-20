# Known issues and limitations

These observations come from **reviewing the uploaded Verilog**; they are not claims of completed hardware validation.

1. **Unassigned overflow flag in equality branch:** In `Converter.v`, for `S == 3'b010` and `G == Y`, the block sets `Led` but does not set `Overflow_Flag`. Because other branches update the flag, this incomplete assignment can infer a latch / retain the prior flag. A complete combinational implementation should explicitly assign the flag for all paths (and consider `always @*`). Original source is retained unchanged for authenticity.
2. **Fahrenheit operations are placeholders:** Both `S=000` and `S=001` force `Led=0` and `Overflow_Flag=1`. They do not calculate `°F = 9/5 × °C + 32` or expose a multi-digit Fahrenheit result. The source comments describe them as overflows.
3. **Limited 3-bit input range:** `G` and `Y` represent 0–7. These are not general-purpose signed/decimal temperature values.
4. **Comparison result is equality-only:** `S=010` displays `E` (equal) or `U` (unequal); it does not indicate which operand is greater.
5. **Incomplete Quartus project:** Block diagrams, pin locations, and waveforms were provided as screenshots. Native `.bdf`, `.qpf`, `.qsf`, and `.vwf` files are absent.
6. **No confirmed hardware programming:** The Programmer screenshot displays “No Hardware”. Its `.sof` listing alone does not confirm a successful board upload.
7. **No independent compile/simulation run:** A supplementary testbench is included for convenience but not executed in the packaging environment.
8. **Target-specific pins:** Pin assignments and I/O standards must be cross-checked against the actual FPGA board and peripheral voltage requirements.

To produce a *verified revised implementation*, first reproduce the original behavior with an HDL simulator, agree on the desired Fahrenheit conversion range and output format, then address the overflow assignment and add regression tests. Keep changes in separate commits so the original work remains traceable.
