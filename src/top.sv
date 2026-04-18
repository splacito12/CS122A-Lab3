module top (
    /** Input Ports */
    input logic clk,
    input logic btn,
    
    /** Output Ports */
    output logic [6:0] seg7
);

/** Logic */
logic debounced_btn;
logic [3:0] duty;   //has to match our bcd

//instantiate the modules
debounce debounce_inst(
    .clk(clk),
    .btn(btn),
    .out(debounced_btn)
);

/*toggle toggle_inst(
    .clk(clk),
    .btn(debounced_btn),
    .led(led)
);*/

dutyCycle dutyCycle_inst(
    .clk(clk),
    .btn(debounced_btn),
    .duty_cycle(duty)
);

decoder decoder_inst(
    .bcd(duty),
    .seg7(seg7)
);

endmodule