//--- stage 1 - get delta signal 

module GET_DELTA_SIGNAL  
(
	input SYS_CLK  , 
	input RESET_N ,
	input signed[13:0] DATA, 
	output reg signed [31:0] DATAOUT
); 
reg signed [13:0] PRE_DATA;
//reg [13:0] PRE_DATA1;
wire signed [31:0] support_product;

//------temp tranform 
parameter multi_b10 = 64553;//0.985*2^16 = 1048392
//assign support_product = multi_b10*PRE_DATA1;
//assign PRODUCT_PREDATA = support_product[30:15];

initial 
begin
	PRE_DATA = 1'b0;
end

assign support_product = multi_b10*PRE_DATA;
//assign PRODUCT_PREDATA = support_product[24:9];

always @(negedge RESET_N or posedge SYS_CLK)
begin
	if (!RESET_N ) begin
		DATAOUT	<= 1'd0;
	end
	else begin
		//PRE_DATA1 <= PRE_DATA;
		
		
		DATAOUT <= (DATA*1024) -(support_product/64);//DATAOUT <= (DATA << 10) -(support_product >> 6);
		PRE_DATA <= DATA;
	end
end


endmodule 

