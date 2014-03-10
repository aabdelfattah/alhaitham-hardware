module center_pos(x_row , y_col ,reset , clk ,center_x,center_y,valid);
 
 input [15:0] x_row; 
 input [15:0] y_col ;
 input  reset;
 input clk ;
 input [15:0] valid ;
 output [15:0] center_x;
 output [15:0] center_y;
 
 reg [15:0] center_x;
 reg [15:0] center_y; 

 reg [31:0] center_x_temp;
 reg [31:0] center_y_temp;
 reg [31:0]pixel_counter ;
 reg [31 : 0 ] dirty ;
 
 always @ (posedge clk)
 
 begin
	if (dirty >= 32'h00075300 )
		begin

	   //center_x = result_x[15:0];
	   //center_y = result_y[15:0];
		
		center_x = 16'h1111;
		//center_y = pixel_counter[15:0];
		center_y = 16'h1111;
		center_x_temp = 32'h00000000;
		center_y_temp = 32'h00000000;
		pixel_counter = 32'h0000FFFF;
		dirty = 32'h00000000;
		
		end

	 else //if (valid [ 7 : 0 ]  == 8'b11111111 ) // pink 
	  begin
		center_y = dirty[31:16];
		center_x = 16'hAAAA;
		center_x_temp = center_x_temp + x_row ;
		center_y_temp = center_y_temp + y_col ;
		pixel_counter = pixel_counter + 32'h00000001;
		dirty = dirty + 32'h00000001;
		end
	
 end

wire [31:0] result_x;
wire [31:0] result_y; 

alt_div div_x(
	.denom(pixel_counter),
	.numer(center_x_temp),
	.quotient(result_x),
	.remain());
 
 
alt_div div_y(
	.denom(pixel_counter),
	.numer(center_y_temp),
	.quotient(result_y),
	.remain());


	

endmodule
 