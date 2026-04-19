`include "src/top.sv"
`include "src/toggle.sv"
`include "src/debounce.sv"
`include "src/dutyCycle.sv"
`include "src/decoder.sv"
`include "src/pwm.sv"
`timescale 1ns/1ps         // Set tick to 1ns. Set sim resolution to 1ps.


module top_tb;

/** declare tb signals below */
logic clk_tb;
logic right_btn;
logic left_btn;
logic red_led;
logic blue_led;
logic [6:0] seg7;
logic switch;
logic dp;

/** declare module(s) below */
top dut                    // declare an inst of top called "dut" (device under test)
(
    /** hook up tb signals to dut signals */
    .clk(clk_tb),           // connect dut's clk wire to clk_tb
    .right_btn(right_btn),
    .left_btn(left_btn),
    .red_led(red_led),
    .blue_led(blue_led),
    .seg7(seg7),
    .switch(switch),
    .dp(dp)
);

localparam CLK_PERIOD = 10; /** clk period */
always #(CLK_PERIOD/2) clk_tb=~clk_tb;          // toggle clk_tb every #(CLK_PERIOD/2) ticks

initial begin
    $dumpfile("build/top.vcd"); // intermediate file for waveform generation
    $dumpvars(0, top_tb.dut);       // capture all signals under top_tb
end

//Use exercise 1 and 2 tb task to test exercsie 1-4
task Rbtn_w_debounce();
    begin
        //rapid toggling
        repeat (6) begin
            right_btn = 1;
            #1000;

            right_btn = 0;
            #1000;
        end

        right_btn = 1;
        #100;

        //release 
        repeat (6) begin
            right_btn = 0;
            #1000;

            right_btn = 1;
            #1000;
        end

        right_btn = 0;
        #100;
    end
endtask

task Lbtn_w_debounce();
    begin
        //rapid toggling
        repeat (6) begin
            left_btn = 1;
            #1000;

            left_btn = 0;
            #1000;
        end

        left_btn = 1;
        #100;

        //release 
        repeat (6) begin
            left_btn = 0;
            #1000;

            left_btn = 1;
            #1000;
        end

        left_btn = 0;
        #100;
    end
endtask

initial begin
    /** testbench logic goes below */
    clk_tb = 0;
    right_btn = 0;
    left_btn = 0;

    #20;

    //press the button multiple times to test it
    Rbtn_w_debounce;
    Rbtn_w_debounce;
    Rbtn_w_debounce;
    Rbtn_w_debounce;

    switch = 1;

    Lbtn_w_debounce;
    Lbtn_w_debounce;
    Lbtn_w_debounce;
    Lbtn_w_debounce;

    switch = 0;

    #200;
    $finish;            // end simulation, otherwise it runs indefinitely
end

endmodule
