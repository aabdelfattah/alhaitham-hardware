module cvinrange(
 HSV1,HSV2,outHSV
);
input[31:0] HSV1 ;
input[31:0] HSV2 ;
output [31:0] outHSV ;


//Those ranges need to be changed to decimal
//they are meaningless in binary form
//pink
assign outHSV[7:0]=( /*H*/8'b10100000 <= HSV1[31:24] && HSV1[31:24] <= 8'b10111001 &&/*S*/ 8'b01100100 <= HSV1[23:16]  &&/*V*/ 8'd50 <= HSV1[15:8] )?(8'b11111111):8'b00000000;
//green
assign outHSV[15:8]=( 8'b00011111 <= HSV2[31:24] && HSV2[31:24] <= 8'b01001001 && 8'b00111100 <= HSV2[23:16]  &&/*V*/ 8'b00111100 <= HSV2[15:8] )?(8'b11111111):8'b00000000;
endmodule 
