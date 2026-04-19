`include "src/toggle.sv"
`include "src/debounce.sv"
`include "src/dutyCycle.sv"
`include "src/decoder.sv"
`include "src/pwm.sv"


module top (
    /** Input Ports */
    input logic clk,
    input logic right_btn,
    input logic left_btn,
    input logic switch,
    
    /** Output Ports */
    output logic [6:0] seg7,
    output logic red_led,
    output logic blue_led,
    output logic dp
);

/** Logic */
logic debounced_Rbtn;
logic debounced_Lbtn;
logic [3:0] duty1;   //has to match our bcd
logic [3:0] duty2;
logic [3:0] led_val;

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

pwm pwm_inst1(
    .clk(clk),
    .duty_cycle(duty1),
    .led(red_led)
);

pwm pwm_inst2(
    .clk(clk),
    .duty_cycle(duty2),
    .led(blue_led)
);

//here is the logic behind switching the seg7 
always_comb begin
    if(switch) begin
        led_val = duty1;
    end
    else begin
        led_val = duty2;
    end
end

decoder decoder_inst(
    .bcd(led_val),
    .seg7(seg7)
);

assign dp = switch;


endmodule