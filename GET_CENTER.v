module GET_CENTER(clk,x_pos,y_pos,binary_pink,binary_green,new_frame,center,rst);
input clk;
input  rst;
input new_frame;
input [15:0] x_pos ;
input [15:0] y_pos ;
input binary_pink;
input binary_green;

output center;

reg [31:0] x_acc ;
reg [31:0] y_acc ;
wire [31:0] result_x ;
wire [31:0] result_y ;
reg [31:0] center;
reg [31:0] pxl_count_pink;

always @ (posedge clk,posedge new_frame)

begin

	if (new_frame == 1'b1 )
	
		begin
		pxl_count_pink <= 32'd1;
		x_acc <=32'd0;
		y_acc <=32'd0;
		end
		
	else if (binary_pink == 1'b1 )
	
		begin 
		pxl_count_pink <= pxl_count_pink + 32'h00000001 ;
		x_acc = x_acc + x_pos;
		y_acc = y_acc + y_pos;
		end
		
end



always @ (posedge new_frame)
	begin
	center <= result_y;
	end


alt_div div_x(
	.denom(pxl_count_pink),
	.numer(x_acc),
	.quotient(result_x),
	.remain());
	
alt_div div_y(
	.denom(pxl_count_pink),
	.numer(y_acc),
	.quotient(result_y),
	.remain());	
	
endmodule