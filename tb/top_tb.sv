`include "src/top.sv"
`include "src/toggle.sv"
`include "src/debounce.sv"
`timescale 1ns/1ps         // Set tick to 1ns. Set sim resolution to 1ps.


module top_tb;

/** declare tb signals below */
logic clk_tb;
logic btn;
logic led;

/** declare module(s) below */
top dut                    // declare an inst of top called "dut" (device under test)
(
    /** hook up tb signals to dut signals */
    .clk(clk_tb),           // connect dut's clk wire to clk_tb
    .btn(btn),
    .led(led)
);

localparam CLK_PERIOD = 5; /** clk period */
always #(CLK_PERIOD/2) clk_tb=~clk_tb;          // toggle clk_tb every #(CLK_PERIOD/2) ticks

initial begin
    $dumpfile("build/top.vcd"); // intermediate file for waveform generation
    $dumpvars(0, top_tb.dut);       // capture all signals under top_tb
end

//here we will be simulating our button press (exercsie 1 and 2) with a task
task btn_w_debounce();
    begin
        //rapid toggling
        repeat (6) begin
            btn = 1;
            #10;

            btn = 0;
            #10;
        end

        btn = 1;
        #100;

        //release 
        repeat (6) begin
            btn = 0;
            #10;

            btn = 1;
            #10;
        end

        btn = 0;
        #100;
    end
endtask

initial begin
    /** testbench logic goes below */
    clk_tb = 0;
    btn = 0;

    #20;

    //press the button multiple times to test it
    btn_w_debounce;
    btn_w_debounce;
    btn_w_debounce;
    btn_w_debounce;

    #200;
    $finish;            // end simulation, otherwise it runs indefinitely
end

endmodule
