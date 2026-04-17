module top (
    /** Input Ports */
    input logic clk,
    input logic btn,
    
    /** Output Ports */
    output logic led
);

/** Logic */
logic debounced_btn;
//logic [3:0] duty;   //has to match our bcd

//instantiate the modules
debounce debounce_inst(
    .clk(clk),
    .btn(btn),
    .out(debounced_btn)
);

toggle toggle_inst(
    .clk(clk),
    .btn(debounced_btn),
    .led(led)
);

endmodule