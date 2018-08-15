module ang_status(input logic vs, Reset_h,a,d,
						output logic [4:0] angle);
						
always@(posedge vs or posedge Reset_h)
begin
if (Reset_h)
	angle<=0;
else
begin
	if(a)
		angle<=angle+1;
	if(d)
		angle<=angle-1;
end

end


endmodule