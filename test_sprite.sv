module test_sprite (
input wire [0:9] row , 
input wire [0:9] col , 
input wire [0:31] angle , 
output wire [0:7] R_out); 
output wire [0:7] G_out); 
output wire [0:7] B_out); 
output wire T_out); //this is alpha channel 0=no pixel
reg [0:24] mem[600][800][32];
always_comb
begin
