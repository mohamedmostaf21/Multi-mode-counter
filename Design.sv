// Code your design here
module counter(
  input clk,
  input reset,
  input [1:0] control_value,
  input INIT,
  input [3:0] count_input,
  output WINNER,
  output LOSER,
  output GAMEOVER,
  output [1:0] WHO,
  output [3:0] count
);
  
  
  reg [3:0] count_r = 0;
  
  reg WINNER_r = 0;
  reg [3:0] WINNER_count = 0;
  reg LOSER_r = 0;
  reg [3:0] LOSER_count = 0;
  reg GAMEOVER_r = 0;
  reg [2:0] WHO_r = 0;
  
  assign WINNER = WINNER_r;
  assign LOSER = LOSER_r;
  assign GAMEOVER = GAMEOVER_r;
  assign WHO = WHO_r;
  assign count = count_r;
    
  
  //count up and down block
  always@(posedge clk, posedge reset) begin
    if(reset) begin
      if(INIT) begin
        count_r <= count_input;
      end
      else begin
        count_r <= 0;
      end
      WINNER_r <= 0;
      WINNER_count <= 0;
      LOSER_r <= 0;
      LOSER_count <= 0;
      GAMEOVER_r <= 0;
      WHO_r <= 0;
    end
    else begin
      
      case(control_value)
        
        2'b00 :
          if(count_r <= 4'b1110) begin
            count_r <= count_r + 1;
          end
          else begin
            count_r <= 4'b1111;
          end
        
        2'b01 :
          if(count_r <= 4'b1101) begin
            count_r <= count_r + 2;
          end
          else begin
            count_r <= 4'b1111;
          end
        
        2'b10 :
          if(count_r >= 4'b0001) begin
            count_r <= count_r - 1;
          end
          else begin
            count_r <= 4'b0000;
          end
        
        2'b11 :
          if(count_r >= 4'b0010) begin
            count_r <= count_r - 2;
          end
          else begin
            count_r <= 4'b0000;
          end
        
      endcase
      
    end
    
  end
  
  //winner and loser block
  always @(posedge clk, posedge reset) begin
    if(reset) begin
      WINNER_r <= 0;
      WINNER_count <= 0;
      LOSER_r <= 0;
      LOSER_count <= 0;
    end
    
    else begin
      
      WINNER_r <= 0;
      LOSER_r <= 0;
      
      if(count_r == 4'b1111) begin
        WINNER_r <= 1;
        WINNER_count <= WINNER_count + 1;
      end
      
      else if(count_r <= 4'b0000) begin
        LOSER_r <= 1;
        LOSER_count <= LOSER_count + 1;
      end
      
      else begin
        WINNER_r <= 0;
        LOSER_r <= 0;
      end
      
    end
  end
  
  //Loading initial value
  always @(posedge INIT, count_input) begin
    
    if(reset) begin
      if(INIT) begin
        count_r <= count_input;
      end
      else begin
        count_r <= 0;
      end
    end
    
    else begin
      
      if(INIT) begin
        count_r <= count_input;
      end
      
    end
    
  end
  
  //WHO and GAMEOVER
  
  always @(posedge clk, posedge reset) begin
    
    if(reset) begin
      GAMEOVER_r <= 0;
      WHO_r <= 0;
    end
    
    else begin
      
      if(GAMEOVER == 1) begin
        if(INIT) begin
          count_r <= count_input;
       end
       else begin
          count_r <= 0;
       end
        WINNER_r <= 0;
        WINNER_count <= 0;
        LOSER_r <= 0;
        LOSER_count <= 0;
        WHO_r <= 0;
       GAMEOVER_r <= 0;
      end
      
      if(LOSER_count == 15) begin
        GAMEOVER_r <= 1'b1;
        WHO_r <= 2'b01;
      end
      
      else if(WINNER_count == 4'b1111) begin
        GAMEOVER_r <= 1'b1;
        WHO_r <= 2'b10;
      end
      
      else begin
        WHO_r <= 0;
       GAMEOVER_r <= 0;
      end
      
    end
    
  end
  
endmodule
