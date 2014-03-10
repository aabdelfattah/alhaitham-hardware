//`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:22:20 06/28/2012 
// Design Name: 
// Module Name:    rgb2hsv 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module rgb2hsv(
clk, 
clk_en,
rst,
RGB,
//xxx,
HSV
    );

input clk, rst;
input[31:0] RGB ;//xxx;
output[31:0] HSV;
input clk_en ;
// h ranges from (0, 360] degrees
// s and v ranges from [0,255] hya bet range mn 0-1 bas for calculation han5aleha from 0-255
// h [31:24] , s [23:16], v[15:8]
reg[31:0] HSV ;
reg[7:0] v_delay_final[2:0]; // Delays v so that h, s, v data lines up correctly
reg[19:0] div ;

wire[7:0] diff; 
reg[31:0] H_old ;
reg signed [9:0] h_int;//ba7ot feha el value mtzabtah bel shifts bta3tha 3ala 7asb el hue_select value
reg[15:0] sat_dividend, sat_divisor;
reg[15:0] hue_dividend, hue_divisor;
//wire[15:0] sat_remainder, hue_remainder;
wire[15:0] sat_quotient, hue_quotient;
 
reg[2:0] hue_select; // Used to correctly modify the output of the hue divider
 
reg[2:0] hue_select_delay; // Accounts for divider delay


wire[7:0] max1 ;
wire[7:0] max;
wire[7:0] min1 ;
wire[7:0] min ;
assign diff = max - min;
assign max1 = (RGB[15:8] > RGB[23:16]) ? RGB[15:8] : RGB[23:16];
assign  max = (max1 > RGB[31:24]) ? max1 : RGB[31:24];
assign min1 = (RGB[15:8] < RGB[23:16]) ? RGB[15:8] : RGB[23:16];
assign min = (min1 < RGB[31:24]) ? min1 : RGB[31:24];

always @ (posedge clk )
begin
if(rst == 1'b1)
begin
	HSV<=0;
end
else if(clk_en == 1'b1)
begin
	HSV[15:8] = max ; 
	case (HSV[15:8])
	8'd0 : div=20'd0;
	8'd1 : div=20'd1044480;
	8'd2 : div=20'd522240;
	8'd3 : div=20'd348160;
	8'd4 : div=20'd261120;
	8'd5 : div=20'd208896;
	8'd6 : div=20'd174080;
	8'd7 : div=20'd149211;
	8'd8 : div=20'd130560;
	8'd9 : div=20'd116053;
	8'd10 : div=20'd104448;
	8'd11 : div=20'd94953;
	8'd12 : div=20'd87040;
	8'd13 : div=20'd80345;
	8'd14 : div=20'd74606;
	8'd15 : div=20'd69632;
	8'd16 : div=20'd65280;
	8'd17 : div=20'd61440;
	8'd18 : div=20'd58027;
	8'd19 : div=20'd54973;
	8'd20 : div=20'd52224;
	8'd21 : div=20'd49737;
	8'd22 : div=20'd47476;
	8'd23 : div=20'd45412;
	8'd24 : div=20'd43520;
	8'd25 : div=20'd41779;
	8'd26 : div=20'd40172;
	8'd27 : div=20'd38684;
	8'd28 : div=20'd37303;
	8'd29 : div=20'd36017;
	8'd30 : div=20'd34816;
	8'd31 : div=20'd33693;
	8'd32 : div=20'd32640;
	8'd33 : div=20'd31651;
	8'd34 : div=20'd30720;
	8'd35 : div=20'd29842;
	8'd36 : div=20'd29013;
	8'd37 : div=20'd28229;
	8'd38 : div=20'd27486;
	8'd39 : div=20'd26782;
	8'd40 : div=20'd26112;
	8'd41 : div=20'd25475;
	8'd42 : div=20'd24869;
	8'd43 : div=20'd24290;
	8'd44 : div=20'd23738;
	8'd45 : div=20'd23211;
	8'd46 : div=20'd22706;
	8'd47 : div=20'd22223;
	8'd48 : div=20'd21760;
	8'd49 : div=20'd21316;
	8'd50 : div=20'd20890;
	8'd51 : div=20'd20480;
	8'd52 : div=20'd20086;
	8'd53 : div=20'd19707;
	8'd54 : div=20'd19342;
	8'd55 : div=20'd18991;
	8'd56 : div=20'd18651;
	8'd57 : div=20'd18324;
	8'd58 : div=20'd18008;
	8'd59 : div=20'd17703;
	8'd60 : div=20'd17408;
	8'd61 : div=20'd17123;
	8'd62 : div=20'd16846;
	8'd63 : div=20'd16579;
	8'd64 : div=20'd16320;
	8'd65 : div=20'd16069;
	8'd66 : div=20'd15825;
	8'd67 : div=20'd15589;
	8'd68 : div=20'd15360;
	8'd69 : div=20'd15137;
	8'd70 : div=20'd14921;
	8'd71 : div=20'd14711;
	8'd72 : div=20'd14507;
	8'd73 : div=20'd14308;
	8'd74 : div=20'd14115;
	8'd75 : div=20'd13926;
	8'd76 : div=20'd13743;
	8'd77 : div=20'd13565;
	8'd78 : div=20'd13391;
	8'd79 : div=20'd13221;
	8'd80 : div=20'd13056;
	8'd81 : div=20'd12895;
	8'd82 : div=20'd12738;
	8'd83 : div=20'd12584;
	8'd84 : div=20'd12434;
	8'd85 : div=20'd12288;
	8'd86 : div=20'd12145;
	8'd87 : div=20'd12006;
	8'd88 : div=20'd11869;
	8'd89 : div=20'd11736;
	8'd90 : div=20'd11605;
	8'd91 : div=20'd11478;
	8'd92 : div=20'd11353;
	8'd93 : div=20'd11231;
	8'd94 : div=20'd11111;
	8'd95 : div=20'd10995;
	8'd96 : div=20'd10880;
	8'd97 : div=20'd10768;
	8'd98 : div=20'd10658;
	8'd99 : div=20'd10550;
	8'd100 : div=20'd10445;
	8'd101 : div=20'd10341;
	8'd102 : div=20'd10240;
	8'd103 : div=20'd10141;
	8'd104 : div=20'd10043;
	8'd105 : div=20'd9947;
	8'd106 : div=20'd9854;
	8'd107 : div=20'd9761;
	8'd108 : div=20'd9671;
	8'd109 : div=20'd9582;
	8'd110 : div=20'd9495;
	8'd111 : div=20'd9410;
	8'd112 : div=20'd9326;
	8'd113 : div=20'd9243;
	8'd114 : div=20'd9162;
	8'd115 : div=20'd9082;
	8'd116 : div=20'd9004;
	8'd117 : div=20'd8927;
	8'd118 : div=20'd8852;
	8'd119 : div=20'd8777;
	8'd120 : div=20'd8704;
	8'd121 : div=20'd8632;
	8'd122 : div=20'd8561;
	8'd123 : div=20'd8492;
	8'd124 : div=20'd8423;
	8'd125 : div=20'd8356;
	8'd126 : div=20'd8290;
	8'd127 : div=20'd8224;
	8'd128 : div=20'd8160;
	8'd129 : div=20'd8097;
	8'd130 : div=20'd8034;
	8'd131 : div=20'd7973;
	8'd132 : div=20'd7913;
	8'd133 : div=20'd7853;
	8'd134 : div=20'd7795;
	8'd135 : div=20'd7737;
	8'd136 : div=20'd7680;
	8'd137 : div=20'd7624;
	8'd138 : div=20'd7569;
	8'd139 : div=20'd7514;
	8'd140 : div=20'd7461;
	8'd141 : div=20'd7408;
	8'd142 : div=20'd7355;
	8'd143 : div=20'd7304;
	8'd144 : div=20'd7253;
	8'd145 : div=20'd7203;
	8'd146 : div=20'd7154;
	8'd147 : div=20'd7105;
	8'd148 : div=20'd7057;
	8'd149 : div=20'd7010;
	8'd150 : div=20'd6963;
	8'd151 : div=20'd6917;
	8'd152 : div=20'd6872;
	8'd153 : div=20'd6827;
	8'd154 : div=20'd6782;
	8'd155 : div=20'd6739;
	8'd156 : div=20'd6695;
	8'd157 : div=20'd6653;
	8'd158 : div=20'd6611;
	8'd159 : div=20'd6569;
	8'd160 : div=20'd6528;
	8'd161 : div=20'd6487;
	8'd162 : div=20'd6447;
	8'd163 : div=20'd6408;
	8'd164 : div=20'd6369;
	8'd165 : div=20'd6330;
	8'd166 : div=20'd6292;
	8'd167 : div=20'd6254;
	8'd168 : div=20'd6217;
	8'd169 : div=20'd6180;
	8'd170 : div=20'd6144;
	8'd171 : div=20'd6108;
	8'd172 : div=20'd6073;
	8'd173 : div=20'd6037;
	8'd174 : div=20'd6003;
	8'd175 : div=20'd5968;
	8'd176 : div=20'd5935;
	8'd177 : div=20'd5901;
	8'd178 : div=20'd5868;
	8'd179 : div=20'd5835;
	8'd180 : div=20'd5803;
	8'd181 : div=20'd5771;
	8'd182 : div=20'd5739;
	8'd183 : div=20'd5708;
	8'd184 : div=20'd5677;
	8'd185 : div=20'd5646;
	8'd186 : div=20'd5615;
	8'd187 : div=20'd5585;
	8'd188 : div=20'd5556;
	8'd189 : div=20'd5526;
	8'd190 : div=20'd5497;
	8'd191 : div=20'd5468;
	8'd192 : div=20'd5440;
	8'd193 : div=20'd5412;
	8'd194 : div=20'd5384;
	8'd195 : div=20'd5356;
	8'd196 : div=20'd5329;
	8'd197 : div=20'd5302;
	8'd198 : div=20'd5275;
	8'd199 : div=20'd5249;
	8'd200 : div=20'd5222;
	8'd201 : div=20'd5196;
	8'd202 : div=20'd5171;
	8'd203 : div=20'd5145;
	8'd204 : div=20'd5120;
	8'd205 : div=20'd5095;
	8'd206 : div=20'd5070;
	8'd207 : div=20'd5046;
	8'd208 : div=20'd5022;
	8'd209 : div=20'd4998;
	8'd210 : div=20'd4974;
	8'd211 : div=20'd4950;
	8'd212 : div=20'd4927;
	8'd213 : div=20'd4904;
	8'd214 : div=20'd4881;
	8'd215 : div=20'd4858;
	8'd216 : div=20'd4836;
	8'd217 : div=20'd4813;
	8'd218 : div=20'd4791;
	8'd219 : div=20'd4769;
	8'd220 : div=20'd4748;
	8'd221 : div=20'd4726;
	8'd222 : div=20'd4705;
	8'd223 : div=20'd4684;
	8'd224 : div=20'd4663;
	8'd225 : div=20'd4642;
	8'd226 : div=20'd4622;
	8'd227 : div=20'd4601;
	8'd228 : div=20'd4581;
	8'd229 : div=20'd4561;
	8'd230 : div=20'd4541;
	8'd231 : div=20'd4522;
	8'd232 : div=20'd4502;
	8'd233 : div=20'd4483;
	8'd234 : div=20'd4464;
	8'd235 : div=20'd4445;
	8'd236 : div=20'd4426;
	8'd237 : div=20'd4407;
	8'd238 : div=20'd4389;
	8'd239 : div=20'd4370;
	8'd240 : div=20'd4352;
	8'd241 : div=20'd4334;
	8'd242 : div=20'd4316;
	8'd243 : div=20'd4298;
	8'd244 : div=20'd4281;
	8'd245 : div=20'd4263;
	8'd246 : div=20'd4246;
	8'd247 : div=20'd4229;
	8'd248 : div=20'd4212;
	8'd249 : div=20'd4195;
	8'd250 : div=20'd4178;
	8'd251 : div=20'd4161;
	8'd252 : div=20'd4145;
	8'd253 : div=20'd4128;
	8'd254 : div=20'd4112;
	8'd255 : div=20'd4096;
	endcase
	HSV[23:16] = ((diff * div)>>12) ;
	case (diff)
	8'd0 : H_old=32'd0;
	8'd1 : H_old=32'd1044480;
	8'd2 : H_old=32'd522240;
	8'd3 : H_old=32'd348160;
	8'd4 : H_old=32'd261120;
	8'd5 : H_old=32'd208896;
	8'd6 : H_old=32'd174080;
	8'd7 : H_old=32'd149211;
	8'd8 : H_old=32'd130560;
	8'd9 : H_old=32'd116053;
	8'd10 : H_old=32'd104448;
	8'd11 : H_old=32'd94953;
	8'd12 : H_old=32'd87040;
	8'd13 : H_old=32'd80345;
	8'd14 : H_old=32'd74606;
	8'd15 : H_old=32'd69632;
	8'd16 : H_old=32'd65280;
	8'd17 : H_old=32'd61440;
	8'd18 : H_old=32'd58027;
	8'd19 : H_old=32'd54973;
	8'd20 : H_old=32'd52224;
	8'd21 : H_old=32'd49737;
	8'd22 : H_old=32'd47476;
	8'd23 : H_old=32'd45412;
	8'd24 : H_old=32'd43520;
	8'd25 : H_old=32'd41779;
	8'd26 : H_old=32'd40172;
	8'd27 : H_old=32'd38684;
	8'd28 : H_old=32'd37303;
	8'd29 : H_old=32'd36017;
	8'd30 : H_old=32'd34816;
	8'd31 : H_old=32'd33693;
	8'd32 : H_old=32'd32640;
	8'd33 : H_old=32'd31651;
	8'd34 : H_old=32'd30720;
	8'd35 : H_old=32'd29842;
	8'd36 : H_old=32'd29013;
	8'd37 : H_old=32'd28229;
	8'd38 : H_old=32'd27486;
	8'd39 : H_old=32'd26782;
	8'd40 : H_old=32'd26112;
	8'd41 : H_old=32'd25475;
	8'd42 : H_old=32'd24869;
	8'd43 : H_old=32'd24290;
	8'd44 : H_old=32'd23738;
	8'd45 : H_old=32'd23211;
	8'd46 : H_old=32'd22706;
	8'd47 : H_old=32'd22223;
	8'd48 : H_old=32'd21760;
	8'd49 : H_old=32'd21316;
	8'd50 : H_old=32'd20890;
	8'd51 : H_old=32'd20480;
	8'd52 : H_old=32'd20086;
	8'd53 : H_old=32'd19707;
	8'd54 : H_old=32'd19342;
	8'd55 : H_old=32'd18991;
	8'd56 : H_old=32'd18651;
	8'd57 : H_old=32'd18324;
	8'd58 : H_old=32'd18008;
	8'd59 : H_old=32'd17703;
	8'd60 : H_old=32'd17408;
	8'd61 : H_old=32'd17123;
	8'd62 : H_old=32'd16846;
	8'd63 : H_old=32'd16579;
	8'd64 : H_old=32'd16320;
	8'd65 : H_old=32'd16069;
	8'd66 : H_old=32'd15825;
	8'd67 : H_old=32'd15589;
	8'd68 : H_old=32'd15360;
	8'd69 : H_old=32'd15137;
	8'd70 : H_old=32'd14921;
	8'd71 : H_old=32'd14711;
	8'd72 : H_old=32'd14507;
	8'd73 : H_old=32'd14308;
	8'd74 : H_old=32'd14115;
	8'd75 : H_old=32'd13926;
	8'd76 : H_old=32'd13743;
	8'd77 : H_old=32'd13565;
	8'd78 : H_old=32'd13391;
	8'd79 : H_old=32'd13221;
	8'd80 : H_old=32'd13056;
	8'd81 : H_old=32'd12895;
	8'd82 : H_old=32'd12738;
	8'd83 : H_old=32'd12584;
	8'd84 : H_old=32'd12434;
	8'd85 : H_old=32'd12288;
	8'd86 : H_old=32'd12145;
	8'd87 : H_old=32'd12006;
	8'd88 : H_old=32'd11869;
	8'd89 : H_old=32'd11736;
	8'd90 : H_old=32'd11605;
	8'd91 : H_old=32'd11478;
	8'd92 : H_old=32'd11353;
	8'd93 : H_old=32'd11231;
	8'd94 : H_old=32'd11111;
	8'd95 : H_old=32'd10995;
	8'd96 : H_old=32'd10880;
	8'd97 : H_old=32'd10768;
	8'd98 : H_old=32'd10658;
	8'd99 : H_old=32'd10550;
	8'd100 : H_old=32'd10445;
	8'd101 : H_old=32'd10341;
	8'd102 : H_old=32'd10240;
	8'd103 : H_old=32'd10141;
	8'd104 : H_old=32'd10043;
	8'd105 : H_old=32'd9947;
	8'd106 : H_old=32'd9854;
	8'd107 : H_old=32'd9761;
	8'd108 : H_old=32'd9671;
	8'd109 : H_old=32'd9582;
	8'd110 : H_old=32'd9495;
	8'd111 : H_old=32'd9410;
	8'd112 : H_old=32'd9326;
	8'd113 : H_old=32'd9243;
	8'd114 : H_old=32'd9162;
	8'd115 : H_old=32'd9082;
	8'd116 : H_old=32'd9004;
	8'd117 : H_old=32'd8927;
	8'd118 : H_old=32'd8852;
	8'd119 : H_old=32'd8777;
	8'd120 : H_old=32'd8704;
	8'd121 : H_old=32'd8632;
	8'd122 : H_old=32'd8561;
	8'd123 : H_old=32'd8492;
	8'd124 : H_old=32'd8423;
	8'd125 : H_old=32'd8356;
	8'd126 : H_old=32'd8290;
	8'd127 : H_old=32'd8224;
	8'd128 : H_old=32'd8160;
	8'd129 : H_old=32'd8097;
	8'd130 : H_old=32'd8034;
	8'd131 : H_old=32'd7973;
	8'd132 : H_old=32'd7913;
	8'd133 : H_old=32'd7853;
	8'd134 : H_old=32'd7795;
	8'd135 : H_old=32'd7737;
	8'd136 : H_old=32'd7680;
	8'd137 : H_old=32'd7624;
	8'd138 : H_old=32'd7569;
	8'd139 : H_old=32'd7514;
	8'd140 : H_old=32'd7461;
	8'd141 : H_old=32'd7408;
	8'd142 : H_old=32'd7355;
	8'd143 : H_old=32'd7304;
	8'd144 : H_old=32'd7253;
	8'd145 : H_old=32'd7203;
	8'd146 : H_old=32'd7154;
	8'd147 : H_old=32'd7105;
	8'd148 : H_old=32'd7057;
	8'd149 : H_old=32'd7010;
	8'd150 : H_old=32'd6963;
	8'd151 : H_old=32'd6917;
	8'd152 : H_old=32'd6872;
	8'd153 : H_old=32'd6827;
	8'd154 : H_old=32'd6782;
	8'd155 : H_old=32'd6739;
	8'd156 : H_old=32'd6695;
	8'd157 : H_old=32'd6653;
	8'd158 : H_old=32'd6611;
	8'd159 : H_old=32'd6569;
	8'd160 : H_old=32'd6528;
	8'd161 : H_old=32'd6487;
	8'd162 : H_old=32'd6447;
	8'd163 : H_old=32'd6408;
	8'd164 : H_old=32'd6369;
	8'd165 : H_old=32'd6330;
	8'd166 : H_old=32'd6292;
	8'd167 : H_old=32'd6254;
	8'd168 : H_old=32'd6217;
	8'd169 : H_old=32'd6180;
	8'd170 : H_old=32'd6144;
	8'd171 : H_old=32'd6108;
	8'd172 : H_old=32'd6073;
	8'd173 : H_old=32'd6037;
	8'd174 : H_old=32'd6003;
	8'd175 : H_old=32'd5968;
	8'd176 : H_old=32'd5935;
	8'd177 : H_old=32'd5901;
	8'd178 : H_old=32'd5868;
	8'd179 : H_old=32'd5835;
	8'd180 : H_old=32'd5803;
	8'd181 : H_old=32'd5771;
	8'd182 : H_old=32'd5739;
	8'd183 : H_old=32'd5708;
	8'd184 : H_old=32'd5677;
	8'd185 : H_old=32'd5646;
	8'd186 : H_old=32'd5615;
	8'd187 : H_old=32'd5585;
	8'd188 : H_old=32'd5556;
	8'd189 : H_old=32'd5526;
	8'd190 : H_old=32'd5497;
	8'd191 : H_old=32'd5468;
	8'd192 : H_old=32'd5440;
	8'd193 : H_old=32'd5412;
	8'd194 : H_old=32'd5384;
	8'd195 : H_old=32'd5356;
	8'd196 : H_old=32'd5329;
	8'd197 : H_old=32'd5302;
	8'd198 : H_old=32'd5275;
	8'd199 : H_old=32'd5249;
	8'd200 : H_old=32'd5222;
	8'd201 : H_old=32'd5196;
	8'd202 : H_old=32'd5171;
	8'd203 : H_old=32'd5145;
	8'd204 : H_old=32'd5120;
	8'd205 : H_old=32'd5095;
	8'd206 : H_old=32'd5070;
	8'd207 : H_old=32'd5046;
	8'd208 : H_old=32'd5022;
	8'd209 : H_old=32'd4998;
	8'd210 : H_old=32'd4974;
	8'd211 : H_old=32'd4950;
	8'd212 : H_old=32'd4927;
	8'd213 : H_old=32'd4904;
	8'd214 : H_old=32'd4881;
	8'd215 : H_old=32'd4858;
	8'd216 : H_old=32'd4836;
	8'd217 : H_old=32'd4813;
	8'd218 : H_old=32'd4791;
	8'd219 : H_old=32'd4769;
	8'd220 : H_old=32'd4748;
	8'd221 : H_old=32'd4726;
	8'd222 : H_old=32'd4705;
	8'd223 : H_old=32'd4684;
	8'd224 : H_old=32'd4663;
	8'd225 : H_old=32'd4642;
	8'd226 : H_old=32'd4622;
	8'd227 : H_old=32'd4601;
	8'd228 : H_old=32'd4581;
	8'd229 : H_old=32'd4561;
	8'd230 : H_old=32'd4541;
	8'd231 : H_old=32'd4522;
	8'd232 : H_old=32'd4502;
	8'd233 : H_old=32'd4483;
	8'd234 : H_old=32'd4464;
	8'd235 : H_old=32'd4445;
	8'd236 : H_old=32'd4426;
	8'd237 : H_old=32'd4407;
	8'd238 : H_old=32'd4389;
	8'd239 : H_old=32'd4370;
	8'd240 : H_old=32'd4352;
	8'd241 : H_old=32'd4334;
	8'd242 : H_old=32'd4316;
	8'd243 : H_old=32'd4298;
	8'd244 : H_old=32'd4281;
	8'd245 : H_old=32'd4263;
	8'd246 : H_old=32'd4246;
	8'd247 : H_old=32'd4229;
	8'd248 : H_old=32'd4212;
	8'd249 : H_old=32'd4195;
	8'd250 : H_old=32'd4178;
	8'd251 : H_old=32'd4161;
	8'd252 : H_old=32'd4145;
	8'd253 : H_old=32'd4128;
	8'd254 : H_old=32'd4112;
	8'd255 : H_old=32'd4096;
	endcase


	if (RGB[15:8] == max) 
	begin  
			if (RGB[23:16] >= RGB[31:24]) 
			begin
				hue_dividend <= {2'b0,((16'd60*(RGB[23:16] - RGB[31:24])*H_old)>>20)};
			end
			else 
			begin
				hue_dividend <= 0- ((16'd60*(RGB[31:24] - RGB[23:16])*H_old)>>20);
			end
	end
	else if (RGB[23:16] == max) 
	begin  
			if (RGB[31:24] >= RGB[15:8])
			begin
			hue_dividend <= (16'd120+((16'd60*(RGB[31:24] - RGB[15:8])*H_old)>>20));
			end
			else 
			begin
			hue_dividend <= (16'd120-((16'd60*(RGB[15:8] - RGB[31:24])*H_old)>>20));
			end


	end
	else 
	begin 
		if (RGB[15:8] >= RGB[23:16]) 
		begin
			hue_dividend <= (16'd240+((16'd60*(RGB[15:8] - RGB[23:16])*H_old)>>20));
		end
		else 
		begin
			hue_dividend <= (16'd240-((16'd60*(RGB[23:16] - RGB[15:8])*H_old)>>20));
			
		end
	end

   h_int = hue_dividend ;
	if (h_int < 0) 
	begin
		HSV[31:24] <= ((h_int >>1)+180);
		HSV[7:0]<=0;
	end
	else
	begin	
		HSV[31:24]<= (h_int>>1);
		HSV[7:0]<=0;
	end
end
//	if (hue_dividend < 0) 
//		H <= ((hue_dividend >>1)+180);
//	else 
//		H <= (hue_dividend>>1);
end

endmodule
