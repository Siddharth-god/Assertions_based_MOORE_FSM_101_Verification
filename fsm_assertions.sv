
// Assertions 
module FSM_ASSERTIONS (
    input logic clk,
    input logic rstn,
    input logic din,
    input logic out,
    input logic [1:0] pre_state
);

    localparam S0 = 2'd0;
    localparam S1 = 2'd1;
    localparam S2 = 2'd2;
    localparam S3 = 2'd3;
    
    // Reset check
    property reset_check;
        @(posedge clk) 
            !rstn |=> pre_state == S0; 
    endproperty : reset_check

    // State check---------------------------------------------------------------------------------------------------------------

    //------------------state s0------------------
    property state_s0_to_s1;
        @(posedge clk)
        disable iff(!rstn)
            (pre_state == S0 && din)
                |=> pre_state == S1;
    endproperty : state_s0_to_s1

    property state_s0_stay;
        @(posedge clk)
        disable iff(!rstn)
            (pre_state == S0 && !din)
                |=> pre_state == S0;
    endproperty : state_s0_stay

    //------------------state s1------------------
    property state_s1_t0_s2;
        @(posedge clk)
        disable iff(!rstn)
            (pre_state == S1 && !din)
                |=> pre_state == S2;
    endproperty : state_s1_t0_s2

    property state_stay_s1;
        @(posedge clk)
        disable iff(!rstn)
            (pre_state == S1 && din)
                |=> pre_state == S1;
    endproperty : state_stay_s1

    //------------------state s2------------------

    property state_s2_to_s3;
        @(posedge clk)
        disable iff(!rstn)
            (pre_state == S2 && din)
                |=> pre_state == S3;
    endproperty : state_s2_to_s3

    property state_s2_to_s0;
        @(posedge clk)
        disable iff(!rstn)
            (pre_state == S2 && !din)
                |=> pre_state == S0;
    endproperty : state_s2_to_s0

    //------------------state s3------------------
    property state_s3_to_s0;
        @(posedge clk)
            disable iff(!rstn)
            (pre_state == S3 && din)
            |=> pre_state == S0 ;
    endproperty : state_s3_to_s0

    property state_s3_to_s1;
        @(posedge clk)
            disable iff(!rstn)
                (pre_state == S3 && !din)
                    |=> pre_state == S1;
    endproperty : state_s3_to_s1

    //------------------Outputs-------------------

    property zero_op_check;
        @(posedge clk) 
            ((  (pre_state == S0) || 
                (pre_state == S1) ||  
                (pre_state == S2)) |-> !out
            );
    endproperty : zero_op_check;


    property op_check;
        @(posedge clk) 
            ( 
            (pre_state == S3) |-> out
            );
    endproperty : op_check;

    //------------------Sequence check-------------------

    property seq_check_101;
        @(posedge clk)
            disable iff(!rstn)
                out |-> ($past(din,3) && !$past(din,2) && $past(din));
    endproperty


    //-----------------Assert_Properties----------------------------------------------------------------------------------------

    // Reset check
    RESET : assert property (reset_check)
                $display("PASS : RESET at time=%0t",$time);
            else 
                $display("FAIL : RESET at time=%0t",$time);

    // State S0
    STATE_S0_TO_S1 : assert property (state_s0_to_s1)
                        $display("PASS : STATE_S0_TO_S1 at time=%0t",$time);
                    else 
                        $display("FAIL : STATE_S0_TO_S1 at time=%0t",$time);

    STATE_S0_STAY : assert property (state_s0_stay)
                        $display("PASS : STATE_S0_STAY at time=%0t",$time);
                    else 
                        $display("FAIL : STATE_S0_STAY at time=%0t",$time);

    // State S1   
    STATE_S1_TO_S2 : assert property (state_s1_t0_s2)
                        $display("PASS : STATE_S1_TO_S2 at time=%0t",$time);
                    else 
                        $display("FAIL : STATE_S1_TO_S2 at time=%0t",$time);

    STATE_STAY_S1 : assert property (state_stay_s1)
                        $display("PASS : STATE_STAY_S1 at time=%0t",$time);
                    else 
                        $display("FAIL : STATE_STAY_S1 at time=%0t",$time);
    
    // State S2
    STATE_S2_TO_S3 : assert property (state_s2_to_s3)
                        $display("PASS : STATE_S2_TO_S3 at time=%0t",$time);
                    else 
                        $display("FAIL : STATE_S2_TO_S3 at time=%0t",$time);
    
    STATE_S2_TO_S0 : assert property (state_s2_to_s0)
                        $display("PASS : STATE_S2_TO_S0 at time=%0t",$time);
                    else 
                        $display("FAIL : STATE_S2_TO_S0 at time=%0t",$time);

    // State S3
    STATE_S3_TO_S0 : assert property (state_s3_to_s0)
                        $display("PASS : STATE_S3_TO_S0 at time=%0t",$time);
                    else 
                        $display("FAIL : STATE_S3_TO_S0 at time=%0t",$time);
    
    STATE_S3_TO_S1 : assert property (state_s3_to_s1)
                        $display("PASS : STATE_S3_TO_S1 at time=%0t",$time);
                    else 
                        $display("FAIL : STATE_S3_TO_S1 at time=%0t",$time);

    // Output Check
    ZERO_OP_CHECK : assert property (zero_op_check)
                        $display("PASS : ZERO_OP_CHECK at time=%0t",$time);
                    else 
                        $display("FAIL : ZERO_OP_CHECK at time=%0t",$time);
    
    OP_CHECK : assert property (op_check)
                    $display("PASS : OP_CHECK at time=%0t",$time);
                else 
                    $display("FAIL : OP_CHECK at time=%0t",$time);

    SEQUENCE_101_CHECK : assert property (seq_check_101)
                            $display("---------PASS--------- : SEQUENCE_101_CHECK at time=%0t",$time);
                        else 
                            $display("---------FAIL--------- : SEQUENCE_101_CHECK at time=%0t",$time);
    
endmodule : FSM_ASSERTIONS

