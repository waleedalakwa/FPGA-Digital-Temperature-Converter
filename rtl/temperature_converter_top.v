// Supplementary HDL top-level reconstructed from the supplied Quartus
// block-diagram screenshots. NOT part of the original uploaded RTL files.
// Copyright (c) 2026 Waleed Alakwa. MIT License; see repository LICENSE.
module temperature_converter_top (
    input  wire [2:0] Selector,
    input  wire [2:0] G,
    input  wire [2:0] Y,
    output wire [6:0] SevenSegment,
    output wire       OverflowFlag
);
    wire [3:0] led_value;

    Converter u_converter (
        .S(Selector),
        .G(G),
        .Y(Y),
        .Led(led_value),
        .Overflow_Flag(OverflowFlag)
    );

    seven_Seg u_seven_segment (
        .Led(led_value),
        .S(Selector),
        .BCD_Output(SevenSegment)
    );
endmodule
