//--- stage 2 - get delta signal 

module STAGE2_GET_SQUARE_SIGNAL  
(
	input SYS_CLK  , 
	input RESET_N ,
	input signed[31:0] DATAIN , 
	output signed [21:0] DATAOUT
) ;

    reg signed [31:0]dataout_support;
    assign DATAOUT = dataout_support[31:10];
	initial
	begin
		dataout_support = 1'b0;
	end
	
	//assign DATAOUT = DATAIN+PRE_DATAOUT;
	
	always@(negedge RESET_N or posedge SYS_CLK)//
	begin
		if (!RESET_N ) begin
			dataout_support <= 1'd0;
		end
		else 
		begin
			if(DATAIN[0]==1'b0 || DATAIN[0]==1'b1) dataout_support <= DATAIN+dataout_support;
			else dataout_support <= dataout_support;
		end
	end
	

endmodule 
