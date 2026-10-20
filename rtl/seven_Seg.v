module seven_Seg(
    input [3:0] Led,
    input [2:0] S,
    output reg [6:0] BCD_Output
);

always @ (Led or S)
begin
    if (Led == 0)
        BCD_Output = 7'b1000000; // 0
    else if (Led == 1)
        BCD_Output = 7'b1111001; // 1
    else if (Led == 2)
        BCD_Output = 7'b0100100; // 2
    else if (Led == 3)
        BCD_Output = 7'b0110000; // 3
    else if (Led == 4)
        BCD_Output = 7'b0011001; // 4
    else if (Led == 5)
        BCD_Output = 7'b0010010; // 5
    else if (Led == 6) begin
        if (S == 3'b010)
            BCD_Output = 7'b0000110; // Display 'E'
        else
            BCD_Output = 7'b0000010; // 6
    end
    else if (Led == 7)
        BCD_Output = 7'b1111000; // 7
    else if (Led == 8)
        BCD_Output = 7'b0000000; // 8
    else if (Led == 9) begin
        if (S == 3'b010)
            BCD_Output = 7'b1000001; // Display 'U'
        else
            BCD_Output = 7'b0010000; // 9
    end
    
    else if (Led == 15)
        BCD_Output = 7'b1111111; // OFF
    else
        BCD_Output = 7'b1000000; // O (default case)
end

endmodule
