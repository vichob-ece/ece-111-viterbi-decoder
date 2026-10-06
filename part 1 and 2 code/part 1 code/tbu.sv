module tbu
(
   input       clk,
   input       rst,
   input       enable,
   input       selection,
   input [7:0] d_in_0,
   input [7:0] d_in_1,
   output logic  d_o,
   output logic  wr_en);

   logic         d_o_reg;
   logic         wr_en_reg;
   
   logic   [2:0] pstate;
   logic   [2:0] nstate;

   logic         selection_buf;

   always @(posedge clk)    begin
      selection_buf  <= selection;
      wr_en          <= wr_en_reg;
      d_o            <= d_o_reg;
   end
   always @(posedge clk, negedge rst) begin
      if(!rst)
         pstate   <= 3'b000;
      else if(!enable)
         pstate   <= 3'b000;
      else if(selection_buf && !selection)
         pstate   <= 3'b000;
      else
         pstate   <= nstate;
   end

/*  combinational logic drives:
wr_en_reg, d_o_reg, nstate (next state)
from selection, d_in_1[pstate], d_in_0[pstate]
See assignment text for details
*/

always_comb begin
	wr_en_reg = selection;
	if (selection) begin
		d_o_reg = d_in_1[pstate];
	end else begin
		d_o_reg = 'b0;
	end
	
	case (pstate)
		3'b000: nstate = (selection ? (d_in_1[0] ? 3'b001 : 3'b000) : (d_in_0[0] ? 3'b001 : 3'b000));
        3'b001: nstate = (selection ? (d_in_1[1] ? 3'b010 : 3'b011) : (d_in_0[1] ? 3'b010 : 3'b011));
        3'b010: nstate = (selection ? (d_in_1[2] ? 3'b101 : 3'b100) : (d_in_0[2] ? 3'b101 : 3'b100));
        3'b011: nstate = (selection ? (d_in_1[3] ? 3'b110 : 3'b111) : (d_in_0[3] ? 3'b110 : 3'b111));
        3'b100: nstate = (selection ? (d_in_1[4] ? 3'b000 : 3'b001) : (d_in_0[4] ? 3'b000 : 3'b001));
        3'b101: nstate = (selection ? (d_in_1[5] ? 3'b011 : 3'b010) : (d_in_0[5] ? 3'b011 : 3'b010));
        3'b110: nstate = (selection ? (d_in_1[6] ? 3'b100 : 3'b101) : (d_in_0[6] ? 3'b100 : 3'b101));
        3'b111: nstate = (selection ? (d_in_1[7] ? 3'b111 : 3'b110) : (d_in_0[7] ? 3'b111 : 3'b110));
		
        default: nstate = pstate;
	endcase
end

endmodule

