# Simulation notes

## Captured evidence

The screenshots labeled `000.png` through `111.png` show the original Quartus Simulation Waveform Editor for each selector setting. The composite image `00552.png` also captures multiple operations. The screenshots are **evidence of the displayed waveforms**, not executable stimulus sources.

| Selector | Captured waveform |
|---|---|
| `000` | [000.png](../assets/screenshots/000.png) |
| `001` | [001.png](../assets/screenshots/001.png) |
| `010` | [010.png](../assets/screenshots/010.png) |
| `011` | [011.png](../assets/screenshots/011.png) |
| `100` | [100.png](../assets/screenshots/100.png) |
| `101` | [101.png](../assets/screenshots/101.png) |
| `110` | [110.png](../assets/screenshots/110.png) |
| `111` | [111.png](../assets/screenshots/111.png) |

## Supplemental testbench

`sim/tb_temperature_converter.v` was prepared based on the uploaded modules. It checks a set of representative output values and highlights the known latch-like behavior of the equality branch. It does not prove timing closure or full functional coverage.

```bash
iverilog -g2012 -o sim/tb_converter.out \
  rtl/Converter.v rtl/seven_Seg.v rtl/temperature_converter_top.v \
  sim/tb_temperature_converter.v
vvp sim/tb_converter.out
```

The testbench has **not** been compiled or executed in the environment where these repository materials were assembled. If you run it, please review actual pass/fail logs and share any discrepancies before marking the design as verified.
