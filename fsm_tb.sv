module fsm_tb;

    logic clk, rstn, din, out;
    int cc = 10;

    FSM_101 DUT(
        .clk(clk),
        .rstn(rstn),
        .din(din),
        .out(out)
    );

    bind FSM_101 FSM_ASSERTIONS ASSERT(
        .clk(clk),
        .rstn(rstn),
        .din(din),
        .out(out),
        .pre_state(pre_state)
    );

    initial begin 
        clk = 0; 
        din = 0;
    end

    always #(cc/2) clk = ~clk;

    initial begin
        rstn = 0;
        #10;
        rstn = 1;

        @(negedge clk) din = 1'b1;
        @(negedge clk) din = 1'b0;
        @(negedge clk) din = 1'b0;
        @(negedge clk) din = 1'b1; // start
        @(negedge clk) din = 1'b0;
        @(negedge clk) din = 1'b1; // sequence 
        @(negedge clk) din = 1'b0;
        @(negedge clk) din = 1'b1; // sequence 
        @(negedge clk) din = 1'b0;

    end

    always@(posedge clk) begin 
        $display("\nclk=%0d | rstn=%0d | din=%0d | out=%0d | pre_state=%0d | next_state=%0d | time=%0t",
                  clk, rstn, din, out, DUT.pre_state, DUT.next_state, $time);
    end

    initial begin 
        //$monitor("clk=%0d | rstn=%0d | din=%0d | out=%0d | pre_state=%0d | next_state=%0d",
        //          clk, rstn, din, out, DUT.pre_state, DUT.next_state);
        $dumpfile("FSM.vcd");
        $dumpvars(0,clk, rstn, din, out, DUT.pre_state, DUT.next_state);
        #150 $finish;
    end
endmodule : fsm_tb

