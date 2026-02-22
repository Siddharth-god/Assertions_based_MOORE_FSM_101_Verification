//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
// 9. Write assertions to verify the FSM which detects the sequence”101”
//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz

module FSM_101(
    input logic clk, rstn, din,
    output logic out
);
    parameter S0 = 2'd0;
    parameter S1 = 2'd1;
    parameter S2 = 2'd2;
    parameter S3 = 2'd3;

    logic [1:0] pre_state, next_state;

    always_ff@(posedge clk) begin 
        if(!rstn)
            pre_state <= S0;
        else 
            pre_state <= next_state;
    end

    always_comb @(pre_state, din) begin 
        case(pre_state)
            S0: if(din) begin 
                    next_state = S1;
                    $display("S0 => S1  at time=%0t",$time);
                end
                else begin
                    next_state = S0;
                    $display("S0 => S0  at time=%0t",$time);
                end

            S1: if(din) begin
                    next_state = S1;
                    $display("S1 => S1  at time=%0t",$time);
                end
                else begin
                    next_state = S2;
                    $display("S1 => S2  at time=%0t",$time);
                end

            S2: if(din) begin
                    next_state = S3;
                    $display("S2 => S3  at time=%0t",$time);
                end
                else begin  
                    next_state = S0;
                    $display("S2 => S0  at time=%0t",$time);
                end

            S3: if(din) begin 
                    next_state = S0;
                    $display("S3 => S0  at time=%0t",$time);
                end
                else begin 
                    next_state = S1;
                    $display("S3 => S1  at time=%0t",$time);
                end
            default : next_state = S0;
        endcase
    end

    assign out = (pre_state == S3);
endmodule : FSM_101