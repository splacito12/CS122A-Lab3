module dutyCycle(
    input logic clk, 
    input logic btn,
    output logic [3:0] duty_cycle
);

typedef enum logic [1:0] {btn_press, btn_release} state_t;
state_t state = btn_press;

//we need to initialize our duty_cycle
initial duty_cycle = 0;

always @(posedge clk) begin
    case(state)
        btn_press: begin
            if(btn) begin
                if(duty_cycle >= 10) begin
                        duty_cycle <= 0;
                end
                else begin
                    duty_cycle <= duty_cycle + 1;
                end
                state <= btn_release;
            end
        end
        btn_release: begin
            if(!btn) begin
                state <= btn_press;
            end
        end

        default: state <= btn_press;
    endcase
end

endmodule