module pwm(
    input logic clk,
    input logic [3:0] duty_cycle,

    output logic led
);

logic [3:0] led_bright = 0;

always @(posedge clk) begin 
    if(led_bright == 9) begin
        led_bright <= 0;
    end
    else begin
        led_bright <= led_bright + 1;
    end
end

//this will control the brightness of the LED based off the duty cycle 
//ex. duty_cycle = 3 so LED is 30% bright
assign led = (led_bright < duty_cycle);

endmodule