module top (
    /** Input Ports */
    input logic clk,
    input logic right_btn,
    input logic left_btn,
    
    /** Output Ports */
    output logic [6:0] seg7,
    output logic red_led,
    output logic blue_led
);

/** Logic */
logic debounced_Rbtn;
logic debounced_Lbtn;
logic [3:0] duty1;   //has to match our bcd
logic [3:0] duty2;

//instantiate the modules
debounce debounce_Rinst(
    .clk(clk),
    .btn(right_btn),
    .out(debounced_Rbtn)
);

debounce debounce_Linst(
    .clk(clk),
    .btn(left_btn),
    .out(debounced_Lbtn)
);

/*toggle toggle_inst(
    .clk(clk),
    .btn(debounced_btn),
    .led(led)
);*/

dutyCycle dutyCycle_inst1(
    .clk(clk),
    .btn(debounced_Rbtn),
    .duty_cycle(duty1)
);

dutyCycle dutyCycle_inst2(
    .clk(clk),
    .btn(debounced_Lbtn),
    .duty_cycle(duty2)
);

decoder decoder_inst(
    .bcd(duty1),
    .seg7(seg7)
);

pwm pwm_inst1(
    .clk(clk),
    .duty_cycle(duty1),
    .led(red_led)
);

pwm pwm_inst2(
    .clk(clk),
    .duty_cycle(duty1),
    .led(blue_led)
);

endmodule