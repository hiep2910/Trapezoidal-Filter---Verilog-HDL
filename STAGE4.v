//--- stage 1 - get delta signal 

module STAGE4  
(
	input SYS_CLK  , 
	input RESET_N ,
	input signed[25:0] DATAIN, 
	output reg signed [13:0] DATAOUT,
	output reg OVERFLOW
);

wire signed [31:0] support_product;

//------temp tranform 
//parameter multi_na_inv = 41;//2^10*0.04 = 40.96 = 41              2^16/150 = 2^16*0.0067 = 436.9
//parameter multi_na_inv = 11;//2^12*(1/375) = 10.9 = 11
parameter multi_na_inv = 273;//2^13*(1/30) = 273 = 273

initial 
begin
	OVERFLOW = 1'b0;
	DATAOUT = 1'b0;
end

assign support_product = (DATAIN[25]==1'b0)? multi_na_inv*DATAIN:1'b0;//PRE_DATA;

always @(negedge RESET_N or posedge SYS_CLK)
begin
	if (!RESET_N ) begin
		DATAOUT	<= 1'b0;
	end
	else begin
		DATAOUT <= support_product[25:13];
		if(support_product[25:12]>14'd8191 && !support_product[25]) OVERFLOW <= 1'b1;
		//else if(support_product[29:10]<=1'b0) DATAOUT <= 1'b0;
		else OVERFLOW <= 1'b0;
		//PRE_DATA <= DATAIN;
	end
end


endmodule 
