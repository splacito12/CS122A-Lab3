module debounce(
    input logic clk, 
    input logic btn,
    output logic out
);

//we will be using count 
logic [19:0] count = 0;

initial out = 0;

always @(posedge clk) begin
    if(btn) begin
        //I should try a threshold between 10-20 ms.
        //10ms = 250000 and 20ms = 500000. 
        if(count < 500000) begin    //use 20 for simulation            
            count <= count + 1;
        end
        else begin
            out <= 1;
        end
    end
    else begin
        //our button is released so everything should be reset
        count <= 0;
        out <= 0; 
    end
end

endmodule
