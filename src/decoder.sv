module decoder (
    /** Input Ports */
    input wire [3:0] bcd,

    /** Output Ports */
    output logic [6:0] seg7
);

/** Logic */
// structure should be like 7'babcdefg
always @(*) begin
    case(bcd)
        4'h0: seg7 = 7'b1111110; //0
        4'h1: seg7 = 7'b0110000; //1
        4'h2: seg7 = 7'b1101101; //2
        4'h3: seg7 = 7'b1111001; //3
        4'h4: seg7 = 7'b0110011; //4
        4'h5: seg7 = 7'b1011011; //5
        4'h6: seg7 = 7'b1011111; //6
        4'h7: seg7 = 7'b1110000; //7
        4'h8: seg7 = 7'b1111111; //8
        4'h9: seg7 = 7'b1110011; //9
        4'hA: seg7 = 7'b1110111; //A
        4'hB: seg7 = 7'b0011111; //B
        4'hC: seg7 = 7'b1001110; //C
        4'hD: seg7 = 7'b0111101; //D
        4'hE: seg7 = 7'b1001111; //E
        4'hF: seg7 = 7'b1000111; //F

        default: seg7 = 7'b0000000;
    endcase
end
endmodule