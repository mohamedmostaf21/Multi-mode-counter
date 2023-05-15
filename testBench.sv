// Code your testbench here
// or browse Examples
module counter_tb();
  
  parameter CYCLE = 5;
  logic clk,reset;
  logic [1:0] control_value;
  logic INIT;
  logic [3:0] count_input;
  logic WINNER;
  logic LOSER;
  logic GAMEOVER;
  logic [1:0] WHO;
  logic [3:0] counter;
  
   counter c1(
    .clk(clk),
    .reset(reset),
    .control_value(control_value),
    .INIT(INIT),
    .count_input(count_input),
    .WINNER(WINNER),
    .LOSER(LOSER),
    .GAMEOVER(GAMEOVER),
    .WHO(WHO),
    .count(counter));
  
  /* Initial Values */
  initial begin
    reset = 0;
    count_input = 4'b0000;
    INIT = 0;
  end
  
  initial begin
    /*
    control_value = 2'b00;
    count_input = 4'b0000;
    INIT = 0;
    reset = 0;
    #20 INIT = 1;
    count_input = 4'b1000;
    #50 reset = 1;
    */
    /* Test Case 1 : Counting up by 1 (Control Value --> 00)*/
    control_value = 2'b00;
    #20 @(posedge clk) reset = 1;
    #1  @(posedge clk) reset = 0;
    /*Test Case 2 : Counting up by 2 (Control Value --> 01)*/
    control_value = 2'b01;
    #30  @(posedge clk) reset = 0;
    /*Test Case 3 : Counting down by 1 (Control Value --> 10)*/
    control_value = 2'b10;
    #20  @(posedge clk) reset = 0;
    /*Test Case 4 : Counting down by 2 (Control Value --> 11)*/
    control_value = 2'b11;
    #20 @(posedge clk) reset = 1;
    #1  @(posedge clk) reset = 0;
    /*Test Case 5 : Initial Value loaded into counter (INIT --> 1)*/
    @(posedge clk) count_input = 4'b1101;
    #1 @(posedge clk) INIT = 1;
    #1 @(posedge clk) INIT = 0;
    /*Test Case 6 : Winner --> 1 for one clock cycle when count is all ones*/
    @(posedge clk) count_input = 4'b1111;
    #1 @(posedge clk) INIT = 1;
    #1 @(posedge clk) count_input = 4'b1101;
    #1 @(posedge clk) INIT = 0;
    /*Test Case 7 : Loser --> 1 for one clock cycle when count is all zeros*/
    @(posedge clk) count_input = 4'b0000;
    #1 @(posedge clk) INIT = 1;
    #1 @(posedge clk) count_input = 4'b1101;
    #1 @(posedge clk) INIT = 0;
    /*Test Case 8 : GAMEOVER --> 1,WHO --> 2'b10 when Winner goes high 15 times*/
    control_value = 2'b00;
    @(posedge clk) count_input = 4'b1111;
    #1  @(posedge clk) INIT = 1;
    #1  @(posedge clk) INIT = 0;
    #60 @(posedge clk) reset = 1;
    #1  @(posedge clk) reset = 0;
    /*Test Case 9 : GAMEOVER --> 1,WHO --> 2'b01 when Loser goes high 15 times*/
    control_value = 2'b10;
    @(posedge clk) count_input = 4'b0000;
    #1  @(posedge clk) INIT = 1;
    #1  @(posedge clk) INIT = 0;
  end
  
  
 
  
  initial begin
    clk = 0;
    forever #(CYCLE/2) clk = ~clk;
  end
  
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #300 $finish;
  end
  
  
  
  
  
endmodule
