# Quartus setup and build notes

## Available assets

Provided: original `Converter.v` and `seven_Seg.v`, block-diagram captures, pin-planning and JTAG Programmer captures, and selector waveform screenshots.

Not provided: the original Quartus `.qpf`, `.qsf`, `.bdf`, waveform `.vwf` / simulator project, synthesis and timing reports, and compiled `.sof` output. Those cannot be recovered reliably from screenshots.

## Suggested new HDL-based project (not the historical original)

1. Install a Quartus version supporting Cyclone IV E and create a new project.
2. Select the FPGA device **EP4CE115F29C7** from the screenshot; check this matches your actual hardware.
3. Add `rtl/Converter.v`, `rtl/seven_Seg.v`, `rtl/temperature_converter_top.v` as Verilog sources.
4. Set `temperature_converter_top` as the top-level entity.
5. Review and adapt `quartus/pin_assignments_example.qsf` to your real board; pay attention to the seven-segment output ordering and I/O standards.
6. Compile, resolve design issues, and inspect warnings. In particular, the equality branch in `Converter.v` leaves `Overflow_Flag` unassigned (incomplete combinational assignment).
7. Simulate all selector values, then use physical programming only if you have the correct board and hardware interface. Never assume screenshot pins match a different FPGA board.

The screenshot of the Quartus Programmer displays **No Hardware** and a `.sof` entry in a JTAG chain, but does not prove that a board was detected or programmed successfully.

If you still have the original Quartus folder, adding the `.qpf`, `.qsf`, `.bdf`, simulation `.vwf` and relevant non-generated reports would make this much more reproducible. Verify authorship/licensing and remove sensitive paths before publishing.
