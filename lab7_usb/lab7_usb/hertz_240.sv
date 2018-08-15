module hertz_240 (input hs, reset, output logic hz_240);

logic [6:0] div_by_128;

always@(posedge hs or posedge reset)
begin
	if (reset) div_by_128 <=0;
	else div_by_128 <= div_by_128 + 1;
end

always_comb
begin
if (div_by_128==0) hz_240 <=1;
else hz_240<=0;
end

endmodule