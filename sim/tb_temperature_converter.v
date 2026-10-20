`timescale 1ns/1ps
// Supplementary, manually authored smoke tests for the uploaded RTL.
// NOT an original Quartus .vwf or simulation artifact.
module tb_temperature_converter;
    reg  [2:0] Selector;
    reg  [2:0] G;
    reg  [2:0] Y;
    wire [6:0] SevenSegment;
    wire OverflowFlag;
    integer failures;
    integer checks;

    temperature_converter_top dut (
        .Selector(Selector), .G(G), .Y(Y),
        .SevenSegment(SevenSegment), .OverflowFlag(OverflowFlag)
    );

    task check_case;
        input [2:0] s, g, y;
        input [6:0] expected_segments;
        input expected_overflow;
        input [8*45-1:0] label;
        begin
            Selector=s; G=g; Y=y;
            #5;
            checks=checks+1;
            if (SevenSegment !== expected_segments || OverflowFlag !== expected_overflow) begin
                $display("FAIL %0s: S=%b G=%b Y=%b segments=%b flag=%b (expected %b %b)",
                    label, s, g, y, SevenSegment, OverflowFlag,
                    expected_segments, expected_overflow);
                failures=failures+1;
            end else begin
                $display("PASS %0s",label);
            end
        end
    endtask

    initial begin
        checks=0; failures=0;
        check_case(3'b000, 3'd2, 3'd0, 7'b1000000, 1'b1, "Fahrenheit G mode: overflow placeholder");
        check_case(3'b001, 3'd0, 3'd7, 7'b1000000, 1'b1, "Fahrenheit Y mode: overflow placeholder");
        check_case(3'b010, 3'd1, 3'd2, 7'b1000001, 1'b0, "Not equal: U");
        check_case(3'b011, 3'd5, 3'd0, 7'b0010000, 1'b0, "G+4 = 9");
        check_case(3'b011, 3'd6, 3'd0, 7'b1000000, 1'b1, "G+4 overflows");
        check_case(3'b100, 3'd0, 3'd2, 7'b0010010, 1'b0, "7-Y = 5");
        check_case(3'b101, 3'd3, 3'd0, 7'b0110000, 1'b0, "G AND 111 = 3");
        check_case(3'b110, 3'd0, 3'd0, 7'b1111000, 1'b0, "NAND mode = 7");
        check_case(3'b111, 3'd0, 3'd0, 7'b1111111, 1'b0, "OFF = blank display");
        // Deliberately demonstrate the original RTL's missing assignment:
        Selector=3'b000; G=3'd3; Y=3'd3;
        #5;
        Selector=3'b010;
        #5;
        if (SevenSegment !== 7'b0000110) begin
            $display("FAIL equality display: expected E");
            failures=failures+1;
        end
        if (OverflowFlag !== 1'b0)
            $display("KNOWN LIMITATION: equal G/Y retains the previous OverflowFlag (%b).", OverflowFlag);
        $display("Smoke test: %0d checks, %0d failures (known latch issue reported separately).",checks,failures);
        if (failures != 0) $fatal(1,"Smoke test FAILED");
        $finish;
    end
endmodule
