# FPGA pin assignments from the supplied screenshot

The supplied Quartus Pin Planner capture identifies a **Cyclone IV E EP4CE115F29C7** and the assignments below. These were transcribed from the screenshot, not read from an original `.qsf` file.

| Signal | Direction | Assigned package pin |
|---|---|---|
| `G[2]` | Input | `PIN_AC26` |
| `G[1]` | Input | `PIN_AB27` |
| `G[0]` | Input | `PIN_AD27` |
| `Selector[2]` | Input | `PIN_AC27` |
| `Selector[1]` | Input | `PIN_AC28` |
| `Selector[0]` | Input | `PIN_AB28` |
| `Y[2]` | Input | `PIN_AC25` |
| `Y[1]` | Input | `PIN_AB26` |
| `Y[0]` | Input | `PIN_AD26` |
| `OverflowFlag` | Output | `PIN_G19` |
| `SevenSegment[6]` | Output | `PIN_H22` |
| `SevenSegment[5]` | Output | `PIN_J22` |
| `SevenSegment[4]` | Output | `PIN_L25` |
| `SevenSegment[3]` | Output | `PIN_L26` |
| `SevenSegment[2]` | Output | `PIN_E17` |
| `SevenSegment[1]` | Output | `PIN_F22` |
| `SevenSegment[0]` | Output | `PIN_G18` |

The screenshot uses `OverflowFlag`, `SevenSegment` and `Selector` as top-level signal names, while the original `Converter.v` has `Overflow_Flag`, `Led`, and `S`. The supplementary top-level module uses the screenshot names.

The screenshot lists **2.5 V (default)** as its I/O standard. This is a **screen-captured setting, not confirmation of electrical compatibility** with your target board. Consult the physical board schematics and pin-voltage requirements before programming hardware.

![Quartus pin planner](../assets/screenshots/pin.png)

An illustrative `.qsf`-style assignment template for the supplementary HDL top-level is provided as [`quartus/pin_assignments_example.qsf`](../quartus/pin_assignments_example.qsf). This does not substitute for the original project configuration.
