module AstroBall(input Reset, frame_clk, Clk,
					input logic [7:0] keycode,
					input logic press,
					input logic [8:0] angle,   //angle goes from 0 - 360. 
               output [9:0]  BallX, BallY, BallS );
					
logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size, Ball_X_reg, Ball_Y_reg;
logic [9:0] Ball_Speed;			

logic ready;
logic speed_up;
logic Clk_divide_by_2, Clk_divide_by_4, Clk_divide_by_8, Clk_divide_by_16, Clk_divide_by_32, Clk_divide_by_64, Clk_divide_by_128;
logic move_clk;

parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
parameter [9:0] Ball_Y_Center=240;  // Center position on the Y axis


assign Ball_Size = 4;

counter counter0(.*,
						.Clk(frame_clk),
						.Reset(Reset));
							
always_comb
begin


	
if(keycode[6:0] == 7'b1110101)
	speed_up <= 1;
else	
	speed_up <= 0;
	

end


always_ff @(posedge Reset or posedge frame_clk)
begin

if(Reset)
begin
	Ball_Speed <= 0;
	Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
	Ball_X_Motion <= 10'd0; //Ball_X_Step;
	//Ball_Y_Pos <= Ball_Y_Center;
	//Ball_X_Pos <= Ball_X_Center;
	//Ball_X_reg <= Ball_X_Center;
	//Ball_Y_reg <= Ball_Y_Center;
end

else
begin
	
if(speed_up & (Ball_Speed < 1020))
	Ball_Speed <= Ball_Speed + 4;
else if(~speed_up & (Ball_Speed > 0))
	Ball_Speed <= Ball_Speed - 1;
else 	
	Ball_Speed <= Ball_Speed;	
	 
	
//Ball_X_Pos <= Ball_X_Pos + Ball_Speed;
//Ball_Y_Pos <= Ball_Y_Pos + Ball_Speed;
	
end	
end

always_comb
begin


if(Ball_Speed > 0 & Ball_Speed < 500)
	move_clk <= Clk_divide_by_128;
else if(Ball_Speed >= 500 & Ball_Speed < 750)
	move_clk <= Clk_divide_by_64;	
else if(Ball_Speed >= 750 & Ball_Speed < 900)
	move_clk <= Clk_divide_by_32;
else if(Ball_Speed >= 900 & Ball_Speed < 960)
	move_clk <= Clk_divide_by_16;
else if(Ball_Speed >= 960 & Ball_Speed < 995)
	move_clk <= Clk_divide_by_8;
else if(Ball_Speed >= 995 & Ball_Speed < 1005)
	move_clk <= Clk_divide_by_4;
else if(Ball_Speed >= 1005 & Ball_Speed < 1010)
	move_clk <= Clk_divide_by_2;	
else 
	move_clk <= frame_clk;	
	
	

end	 
   
always_ff @ (posedge move_clk or posedge Reset)
begin

	if(Reset)
	begin
	Ball_X_reg <= Ball_X_Center;
	Ball_Y_reg <= Ball_Y_Center;
	end
	else if(keycode[6:0] == 7'b1110101)  // distance traveled isnt always the same. But the angle is correct for each movement. Just need a way to change the angle now
	begin
		if(angle == 0)
			begin
				Ball_X_reg <= Ball_X_reg + 1;
				Ball_Y_reg <= Ball_Y_reg;
			end
		else if(angle == 30) // actually 30.96 degrees
			begin
				Ball_X_reg <= Ball_X_reg + 5;
				Ball_Y_reg <= Ball_Y_reg - 3;			
			end
		else if(angle == 45)
			begin
				Ball_X_reg <= Ball_X_reg + 1;
				Ball_Y_reg <= Ball_Y_reg - 1;			
			end
		else if(angle == 60) // actually 59.04 degrees 
			begin
				Ball_X_reg <= Ball_X_reg + 3;
				Ball_Y_reg <= Ball_Y_reg - 5;			
			end
		else if(angle == 90)
			begin
				Ball_X_reg <= Ball_X_reg;
				Ball_Y_reg <= Ball_Y_reg - 1;			
			end
		else if(angle == 120) // actually 120.96 degrees 
			begin
				Ball_X_reg <= Ball_X_reg - 3;
				Ball_Y_reg <= Ball_Y_reg - 5;
			end
		else if(angle == 135)
			begin
				Ball_X_reg <= Ball_X_reg - 1;
				Ball_Y_reg <= Ball_Y_reg - 1;			
			end
		else if(angle == 150) // actually 149.04 degrees
			begin
				Ball_X_reg <= Ball_X_reg - 5;
				Ball_Y_reg <= Ball_Y_reg - 3;			
			end
		else if(angle == 180)
			begin
				Ball_X_reg <= Ball_X_reg - 1;
				Ball_Y_reg <= Ball_Y_reg;			
			end
		else if(angle == 210) // actually 210.96 degrees
			begin
				Ball_X_reg <= Ball_X_reg - 5;
				Ball_Y_reg <= Ball_Y_reg + 3;			
			end
		else if(angle == 225)
			begin
				Ball_X_reg <= Ball_X_reg - 1;
				Ball_Y_reg <= Ball_Y_reg + 1;			
			end
		else if(angle == 240) // actually 239.04 degrees
			begin
				Ball_X_reg <= Ball_X_reg - 3;
				Ball_Y_reg <= Ball_Y_reg + 5;
			end
		else if(angle == 270)
			begin
				Ball_X_reg <= Ball_X_reg;
				Ball_Y_reg <= Ball_Y_reg + 1;			
			end
		else if(angle == 300) // actually 300.96 degrees
			begin
				Ball_X_reg <= Ball_X_reg + 3;
				Ball_Y_reg <= Ball_Y_reg + 5;			
			end
		else if(angle == 315)
			begin
				Ball_X_reg <= Ball_X_reg + 1;
				Ball_Y_reg <= Ball_Y_reg - 1;			
			end
		else if(angle == 330) // actually 329.04 degrees 
			begin
				Ball_X_reg <= Ball_X_reg + 5;
				Ball_Y_reg <= Ball_Y_reg + 3;			
			end
	end
end	
	
	 //assign BallX = Ball_X_Pos;
   
    //assign BallY = Ball_Y_Pos;
   
	assign BallX = Ball_X_reg;
	assign BallY = Ball_Y_reg;
	
    assign BallS = Ball_Size;
endmodule							