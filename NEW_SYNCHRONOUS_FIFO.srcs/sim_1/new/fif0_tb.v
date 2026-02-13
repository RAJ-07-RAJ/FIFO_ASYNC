
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2026 06:06:39 PM
// Design Name: 
// Module Name: fif0_tb
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


// Code your testbench here
// or browse Examples// Code your testbench here
// or browse Examples

module fif0_tb;
parameter PTR_WIDTH=3;
parameter DATA_WIDTH=8;
 parameter DEPTH      = 1 << PTR_WIDTH;
reg wclk,rclk;
reg wrst_n,rrst_n;
reg w_en,r_en;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;
 wire [PTR_WIDTH:0] g_wptr_sync;
 wire [PTR_WIDTH:0] g_rptr_sync;
wire full_w,empty_w;

fifo_top  #(.PTR_WIDTH(PTR_WIDTH)) utt
    (.wclk(wclk),.wrst_n(wrst_n),.w_en(w_en),.g_wptr_sync( g_wptr_sync) ,. data_in( data_in),. full_w( full_w),
    .rclk(rclk),.rrst_n(rrst_n),.r_en(r_en),.g_rptr_sync( g_rptr_sync) ,. data_out( data_out),. empty_w( empty_w));
always #10 wclk =~wclk;
always #5 rclk =~rclk;
 initial begin
    wclk = 0; rclk = 0;
    w_en = 0; r_en = 0;
    data_in = 0;
    wrst_n = 0; rrst_n = 0;

    // Reset sequencing
    repeat (5) @(posedge wclk);
    wrst_n = 1;

    repeat (5) @(posedge rclk);
    rrst_n = 1;

    // ✅ Wait for reset synchronization
    repeat (10) @(posedge wclk);
    repeat (10) @(posedge rclk);

    // ---------------- WRITE PHASE ----------------
    repeat (DEPTH + 3) begin
      
      if (!full_w) begin
        w_en = 1;
        @(posedge wclk);
        data_in = $random;
        $display("write: %h", data_in);
         $display("em ra O");
        
      end else begin
        w_en = 0;
      end
    end
    w_en = 0;
    
    // ✅ CRITICAL: Wait for write pointer to sync to read domain
    repeat (20) @(posedge rclk);

    // ❌ REMOVE THIS LINE - Don't reset again!
    // rrst_n = 1;  
    
    // ---------------- READ PHASE ----------------
    repeat (DEPTH + 3) begin
      @(posedge rclk);  
     // if (!empty_w) begin
        r_en = 1;
       // @(posedge rclk);  
         $display("READ: %h", data_out);
     // end
     // else
       
    end
  

    repeat (10) @(posedge wclk);
    $display("FIFO TEST PASSED");
    $finish;
  end

endmodule

