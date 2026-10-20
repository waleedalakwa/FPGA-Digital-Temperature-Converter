module Converter(

    input [2:0] S,             // Operation selector (S2 S1 S0)
    input [2:0] G,             // 3-bit input temperature G (°C)
    input [2:0] Y,             // 3-bit input temperature Y (°C)
    
    output reg [3:0] Led,      // 4-bit output to 7-segment display
    output reg Overflow_Flag   // Overflow indicator (1 if result > 9)

);
    
    always @(G, Y, S)
    begin
        if (S == 3'b000) // G → Fahrenheit (always overflows)
        begin
            Led[0] = 0;
            Led[1] = 0;
            Led[2] = 0;
            Led[3] = 0;
            Overflow_Flag = 1;
        end
        else if (S == 3'b001) // Y → Fahrenheit (always overflows)
        begin
            Led[0] = 0;
            Led[1] = 0;
            Led[2] = 0;
            Led[3] = 0;
            Overflow_Flag = 1;
        end
        else if (S == 3'b010) // Compare G and Y
        begin
            if (G == Y) begin
                // Display 'E'
                Led[0] = 0;
                Led[1] = 1;
                Led[2] = 1;
                Led[3] = 0;
				end
            else begin
                // Display 'U'
                Led[0] = 1;
                Led[1] = 0;
                Led[2] = 0;
                Led[3] = 1;
            Overflow_Flag = 0;
				end
        end
        else if (S == 3'b011) // G + 4 with overflow check
        begin
            if ((G + 4) > 9) begin
                Led[0] = 0;
                Led[1] = 0;
                Led[2] = 0;
                Led[3] = 0;
                Overflow_Flag = 1;
            end
            else begin
                Led[0] = G[0];
                Led[1] = G[1];
                Led[2] = ~G[2];
                Led[3] = G[2];
                Overflow_Flag = 0;
            end
        end
        else if (S == 3'b100) // 7 - Y (bitwise NOT of Y)
        begin
            Led[0] = ~Y[0];
            Led[1] = ~Y[1];
            Led[2] = ~Y[2];
            Led[3] = 0;
            Overflow_Flag = 0;
        end
        else if (S == 3'b101) // G bitwise AND 111 (show G)
        begin
            Led[0] = G[0];
            Led[1] = G[1];
            Led[2] = G[2];
            Led[3] = 0;
            Overflow_Flag = 0;
        end
        else if (S == 3'b110) // G AND 000 → 000 → NAND = 111
        begin
            Led[0] = 1;
            Led[1] = 1;
            Led[2] = 1;
            Led[3] = 0;
            Overflow_Flag = 0;
        end
        else begin // System OFF → show 1111
            Led[0] = 1;
            Led[1] = 1;
            Led[2] = 1;
            Led[3] = 1;
            Overflow_Flag = 0;
        end
    end
endmodule
