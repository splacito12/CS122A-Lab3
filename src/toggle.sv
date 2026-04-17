module toggle(
    input logic clk,
    input logic btn,
    output logic led
);

typedef enum logic [1:0] {off, pressed} state_t;
state_t state = off;

//initialiZe led
initial led = 0;

always @(posedge clk) begin
    case(state)
        off: begin
            if(btn) begin
                led <= ~led;
                state <= pressed;
            end 
            else begin
                state = off;
            end 
        end
        pressed: begin
            if(!btn) begin
                state <= off;
            end
            else begin
                state <= pressed;
            end
        end

        default: state <= off;
    endcase
end

endmodule