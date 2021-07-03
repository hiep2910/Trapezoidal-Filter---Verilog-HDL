//--- stage 3 - integral part 

module STAGE3_INTEGRAL_PART  
(
	input SYS_CLK  , 
	input RESET_N ,
	input signed[21:0] DATAIN , 
	output reg signed [25:0] DATAOUT
);
	
	initial
	begin
		DATAOUT = 1'b0;
	end
	
	//assign DATAOUT = DATAIN+PRE_DATAOUT;
	
	always@(negedge RESET_N or posedge SYS_CLK)//
	begin
		if (!RESET_N ) begin
			DATAOUT <= 26'd0;
		end
		else 
		begin
			if(DATAIN[0]==1'b0 || DATAIN[0]==1'b1) DATAOUT <= DATAIN+DATAOUT;
			else DATAOUT <= DATAOUT;
		end
	end

endmodule 