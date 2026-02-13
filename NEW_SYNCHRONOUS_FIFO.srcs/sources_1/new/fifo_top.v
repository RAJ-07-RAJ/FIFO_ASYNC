`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2026 06:00:50 PM
// Design Name: 
// Module Name: fifo_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo_top #(parameter PTR_WIDTH=3,DATA_WIDTH=8)(
  input  wclk, wrst_n, w_en,
 input  rclk, rrst_n, r_en,
 input [DATA_WIDTH-1:0] data_in,
 output  [PTR_WIDTH:0] g_wptr_sync,
 output [PTR_WIDTH:0] g_rptr_sync,
 output  [DATA_WIDTH-1:0] data_out,
  output  full_w,empty_w
);




  wire [DATA_WIDTH-1:0] data_out_int;
  wire [PTR_WIDTH:0] b_wptr, g_wptr;
  wire [PTR_WIDTH:0] b_rptr, g_rptr;
 
synchronizer #(.WIDTH(PTR_WIDTH)) sync_w (
    .clk(rclk),
    .rst_n(rrst_n),
    .d_in(g_wptr),
    .d_out(g_wptr_sync)
  );
  
  synchronizer #(.WIDTH(PTR_WIDTH)) sync_r (
    .clk(wclk),
    .rst_n(wrst_n),
    .d_in(g_rptr),
    .d_out(g_rptr_sync)
  );
  
  wptr_handler #(.PTR_WIDTH(PTR_WIDTH)) DUT (
    .wclk(wclk),
    .wrst_n(wrst_n),
    .w_en(w_en),
    .g_rptr_sync(g_rptr_sync),
    .b_wptr(b_wptr),
    .g_wptr(g_wptr),
    .full(full_w)
  );

  
rptr_handler #(.PTR_WIDTH(PTR_WIDTH)) uut (
    .rclk(rclk),
    .rrst_n(rrst_n),
    .r_en(r_en),
    .g_wptr_sync(g_wptr_sync),
    .b_rptr(b_rptr),
    .g_rptr(g_rptr),
    .empty(empty_w)
  );
    
fifo_mem #(
  .DEPTH(1 << PTR_WIDTH),
  .DATA_WIDTH(DATA_WIDTH),
  .PTR_WIDTH(PTR_WIDTH)
) mem_inst (
 // .rrst_n(rrst_n),
  .wclk     (wclk),
  .w_en     (w_en),
  .rclk     (rclk),
  .r_en     (r_en),
  .b_wptr   (b_wptr),
  .b_rptr   (b_rptr),
  .data_in  (data_in),
  .full     (full_w),
  .empty    (empty_w),
  .data_out (data_out_int)
);

assign data_out = data_out_int;
endmodule

