//--- stage 3 - integral part 

module STAGE3_COMB_PART  
(
	input SYS_CLK  , 
	input RESET_N ,
	input signed[25:0] DATAIN , 
	output reg signed [25:0] DATAOUT
) ;
	
	wire signed[25:0] DATADELAY27;
	always@(negedge RESET_N or posedge SYS_CLK)
	begin
		if (!RESET_N ) begin
			DATAOUT	<= 1'b0;
		end
		else begin
			DATAOUT	<= DATAIN-DATADELAY27;
		end
	end
	
	fifo_mem27deep get_datadelay27(.data_out(DATADELAY27) ,.clk(SYS_CLK) , .rst_n(RESET_N) , .wr(DATAIN[0]==1'b1 || DATAIN[0]==1'b0), .data_in(DATAIN));
	//defparam get_datadelay247.fifo_Deep = 8'd247;
	//defparam get_datadelay247.DATA_WIDTH = 6'd26;

endmodule 