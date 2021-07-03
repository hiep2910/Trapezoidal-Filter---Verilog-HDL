//--- stage 2 - get delta signal 

module STAGE2_COMB_PART  
(
	input SYS_CLK  , 
	input RESET_N ,
	input signed[31:0] DATA , 
	output reg signed [31:0] DATAOUT
) ;

	wire signed[31:0] DATADELAY372;
	always@(negedge RESET_N or posedge SYS_CLK)
	begin
		if (!RESET_N ) begin
			DATAOUT	<= 1'd0;
		end
		else begin
			DATAOUT	<= DATA-DATADELAY372;
		end
	end
	
	fifo_mem get_datadelay372(.data_out(DATADELAY372) ,.clk(SYS_CLK) , .rst_n(RESET_N) , .wr(DATA[15]==1'b1 || DATA[15]==1'b0), .data_in(DATA));

endmodule 

