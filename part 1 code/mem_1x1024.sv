/*make the data path K bits wide for mem_Kx1024
   K=8 for module mem, K=1 for module mem_disp */ 
module mem_disp					(
   input                  clk,
   input                  wr,	 // write enable
   input         [9:0]    addr,
   input                  d_i,		// data
   output logic           d_o);
//  memory core itself   
   logic                  mem   [1024];

   always @ (posedge clk) 
	begin
		if (wr) begin
			mem[addr] <= d_i;
		end
		
		d_o <= mem[addr];
	end
endmodule
