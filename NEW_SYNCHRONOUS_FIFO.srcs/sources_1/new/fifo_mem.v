
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2026 05:59:14 PM
// Design Name: 
// Module Name: fifo_mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: ;
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo_mem #(parameter DEPTH=8, DATA_WIDTH=8, PTR_WIDTH=3) (
  input wclk, w_en, rclk, r_en,//rrst_n,
  input [PTR_WIDTH:0] b_wptr, b_rptr,
  input [DATA_WIDTH-1:0] data_in,
  input full, empty,
  output  [DATA_WIDTH-1:0] data_out
);
  reg [DATA_WIDTH-1:0] fifo[0:DEPTH-1];
  //reg [DATA_WIDTH-1:0]data_out_in;
  always@(posedge wclk) begin
    if(w_en & !full) begin
      fifo[b_wptr[PTR_WIDTH-1:0]] <= data_in;
    end
  end

//  always @(posedge rclk) begin
//  if (!rrst_n)
//    data_out_in <= 0;
//  else if (r_en && !empty)
//   data_out_in <= fifo[b_rptr[PTR_WIDTH-1:0]];
//end

  assign data_out = (r_en && !empty)?fifo[b_rptr[PTR_WIDTH-1:0]]:4'b0 ;
  
 
endmodule
