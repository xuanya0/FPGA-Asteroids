module hertz_480 (input hs, reset, output logic hz_480);

logic [5:0] div_by_64;

always@(posedge hs or posedge reset)
begin
	if (reset) div_by_64 <=0;
	else div_by_64 <= div_by_64 + 1;
end

always_comb
begin
if (div_by_64==0) hz_480 <=1;
else hz_480<=0;
end

endmodule