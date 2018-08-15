module game_control(input       [9:0] ship_x, ship_y,
												  rock_x, rock_y, 
												  rock_x_1, rock_y_1, 
												  rock_x_2, rock_y_2, 
												  rock_x_3, rock_y_3,
												  shot_x, shot_y,
												  shot_x_1, shot_y_1,
												  shot_x_2, shot_y_2,
												  shot_x_3, shot_y_3,
							
						  input hs,vs, Reset_h,
						  output logic [3:0] reset_rocks, reset_shots,
						  output logic reset_ship, hit);
						  
	
wire rst_imp;
logic [1:0] counter_4;

three_sec ts0(.*, .vs(vs), .reset(Reset_h));
always@(posedge rst_imp or posedge Reset_h)
begin
	if (Reset_h) counter_4 <= 0;
	else
	counter_4 <= counter_4 +1;
end




logic [3:0] withhold_rocks;
						  
always@(posedge hs or posedge Reset_h)
begin
	if (Reset_h) withhold_rocks <= 4'b1111;
	else
	case(counter_4)
	2'b00: withhold_rocks[0] <= 0;
	2'b01: withhold_rocks[1] <= 0;
	2'b10: withhold_rocks[2] <= 0;
	2'b11: withhold_rocks[3] <= 0;
	endcase
	
end

always_comb
begin
	if ((rock_x <= ship_x + 48) && (rock_y <= ship_y + 48) && (rock_x >= ship_x - 48) && (rock_y >= ship_y - 48))
		begin reset_rocks[0] <= 1; reset_ship <= 1; end
	else 
		begin reset_rocks[0] <= withhold_rocks[0]; reset_ship <=0; end
		
		
		
	if ((rock_x_1 <= ship_x + 48) && (rock_y_1 <= ship_y + 48) && (rock_x_1 >= ship_x - 48) && (rock_y_1 >= ship_y - 48))
		begin reset_rocks[1] <= 1; reset_ship <= 1; end
	else 
		begin reset_rocks[1] <= withhold_rocks[1]; reset_ship <=0; end
		
		
		
	if ((rock_x_2 <= ship_x + 48) && (rock_y_2 <= ship_y + 48) && (rock_x_2 >= ship_x - 48) && (rock_y_2 >= ship_y - 48))
		begin reset_rocks[2] <= 1; reset_ship <= 1; end
	else 
		begin reset_rocks[2] <= withhold_rocks[2]; reset_ship <=0; end
		
		
		
		
	if ((rock_x_3 <= ship_x + 48) && (rock_y_3 <= ship_y + 48) && (rock_x_3 >= ship_x - 48) && (rock_y_3 >= ship_y - 48))
		begin reset_rocks[3] <= 1; reset_ship <= 1; end
	else 
		begin reset_rocks[3] <= withhold_rocks[3]; reset_ship <=0; end
	
	
	//----shots below
	    if ((rock_x <= shot_x + 32) && (rock_y <= shot_y + 32) && (rock_x >= shot_x - 32) && (rock_y >= shot_y - 32))
		begin reset_rocks[0] <= 1; reset_shots[0] <= 1; hit=1; end
	else 
		begin reset_rocks[0] <= withhold_rocks[0]; reset_shots[0] <=0; hit=0; end
		
		
		
	if ((rock_x_1 <= shot_x + 32) && (rock_y_1 <= shot_y + 32) && (rock_x_1 >= shot_x - 32) && (rock_y_1 >= shot_y - 32))
		begin reset_rocks[1] <= 1; reset_shots[0] <= 1; hit=1; end
	else 
		begin reset_rocks[1] <= withhold_rocks[1]; reset_shots[0] <=0; hit=0; end
		
		
		
	if ((rock_x_2 <= shot_x + 32) && (rock_y_2 <= shot_y + 32) && (rock_x_2 >= shot_x - 32) && (rock_y_2 >= shot_y - 32))
		begin reset_rocks[2] <= 1; reset_shots[0] <= 1; hit=1; end
	else 
		begin reset_rocks[2] <= withhold_rocks[2]; reset_shots[0] <=0; hit=0; end
		
		
		
		
	if ((rock_x_3 <= shot_x + 32) && (rock_y_3 <= shot_y + 32) && (rock_x_3 >= shot_x - 32) && (rock_y_3 >= shot_y - 32))
		begin reset_rocks[3] <= 1; reset_shots[0] <= 1; hit=1; end
	else 
		begin reset_rocks[3] <= withhold_rocks[3]; reset_shots[0] <=0; hit=0; end
		
    //------------shot_1
		
	if ((rock_x <= shot_x_1 + 32) && (rock_y <= shot_y_1 + 32) && (rock_x >= shot_x_1 - 32) && (rock_y >= shot_y_1 - 32))
		begin reset_rocks[0] <= 1; reset_shots[1] <= 1; hit=1; end
	else 
		begin reset_rocks[0] <= withhold_rocks[0]; reset_shots[1] <=0; hit=0; end
		
		
		
	if ((rock_x_1 <= shot_x_1 + 32) && (rock_y_1 <= shot_y_1 + 32) && (rock_x_1 >= shot_x_1 - 32) && (rock_y_1 >= shot_y_1 - 32))
		begin reset_rocks[1] <= 1; reset_shots[1] <= 1; hit=1; end
	else 
		begin reset_rocks[1] <= withhold_rocks[1]; reset_shots[1] <=0; hit=0; end
		
		
		
	if ((rock_x_2 <= shot_x_1 + 32) && (rock_y_2 <= shot_y_1 + 32) && (rock_x_2 >= shot_x_1 - 32) && (rock_y_2 >= shot_y_1 - 32))
		begin reset_rocks[2] <= 1; reset_shots[1] <= 1; hit=1; end
	else 
		begin reset_rocks[2] <= withhold_rocks[2]; reset_shots[1] <=0; hit=0; end
		
		
		
		
	if ((rock_x_3 <= shot_x_1 + 32) && (rock_y_3 <= shot_y_1 + 32) && (rock_x_3 >= shot_x_1 - 32) && (rock_y_3 >= shot_y_1 - 32))
		begin reset_rocks[3] <= 1; reset_shots[1] <= 1; hit=1; end
	else 
		begin reset_rocks[3] <= withhold_rocks[3]; reset_shots[1] <=0; hit=0; end
		
		
		
	//-----------------------shot_2
		
		
		if ((rock_x <= shot_x_2 + 32) && (rock_y <= shot_y_2 + 32) && (rock_x >= shot_x_2 - 32) && (rock_y >= shot_y_2 - 32))
		begin reset_rocks[0] <= 1; reset_shots[2] <= 1; hit=1; end
	else 
		begin reset_rocks[0] <= withhold_rocks[0]; reset_shots[2] <=0; hit=0; end
		
		
		
	if ((rock_x_1 <= shot_x_2 + 32) && (rock_y_1 <= shot_y_2 + 32) && (rock_x_1 >= shot_x_2 - 32) && (rock_y_1 >= shot_y_2 - 32))
		begin reset_rocks[1] <= 1; reset_shots[2] <= 1; hit=1; end
	else 
		begin reset_rocks[1] <= withhold_rocks[1]; reset_shots[2] <=0; hit=0; end
		
		
		
	if ((rock_x_2 <= shot_x_2 + 32) && (rock_y_2 <= shot_y_2 + 32) && (rock_x_2 >= shot_x_2 - 32) && (rock_y_2 >= shot_y_2 - 32))
		begin reset_rocks[2] <= 1; reset_shots[2] <= 1; hit=1; end
	else 
		begin reset_rocks[2] <= withhold_rocks[2]; reset_shots[2] <=0; hit=0; end
		
		
		
		
	if ((rock_x_3 <= shot_x_2 + 32) && (rock_y_3 <= shot_y_2 + 32) && (rock_x_3 >= shot_x_2 - 32) && (rock_y_3 >= shot_y_2 - 32))
		begin reset_rocks[3] <= 1; reset_shots[2] <= 1; hit=1; end
	else 
		begin reset_rocks[3] <= withhold_rocks[3]; reset_shots[2] <=0; hit=0; end
		
		
	//----------------------shot_3
		
		
		
		
		if ((rock_x <= shot_x_3 + 32) && (rock_y <= shot_y_3 + 32) && (rock_x >= shot_x_3 - 32) && (rock_y >= shot_y_3 - 32))
		begin reset_rocks[0] <= 1; reset_shots[3] <= 1; hit=1; end
	else 
		begin reset_rocks[0] <= withhold_rocks[0]; reset_shots[3] <=0; hit=0; end
		
		
		
	if ((rock_x_1 <= shot_x_3 + 32) && (rock_y_1 <= shot_y_3 + 32) && (rock_x_1 >= shot_x_3 - 32) && (rock_y_1 >= shot_y_3 - 32))
		begin reset_rocks[1] <= 1; reset_shots[3] <= 1; hit=1; end
	else 
		begin reset_rocks[1] <= withhold_rocks[1]; reset_shots[3] <=0; hit=0; end
		
		
		
	if ((rock_x_2 <= shot_x_3 + 32) && (rock_y_2 <= shot_y_3 + 32) && (rock_x_2 >= shot_x_3 - 32) && (rock_y_2 >= shot_y_3 - 32))
		begin reset_rocks[2] <= 1; reset_shots[3] <= 1; hit=1; end
	else 
		begin reset_rocks[2] <= withhold_rocks[2]; reset_shots[3] <=0; hit=0; end
		
		
		
	if ((rock_x_3 <= shot_x_3 + 32) && (rock_y_3 <= shot_y_3 + 32) && (rock_x_3 >= shot_x_3 - 32) && (rock_y_3 >= shot_y_3 - 32))
		begin reset_rocks[3] <= 1; reset_shots[3] <= 1; hit=1; end
	else 
		begin reset_rocks[3] <= withhold_rocks[3]; reset_shots[3] <=0; hit=0; end
		
	


end


endmodule
