% clear previous connection. Start a new connection with the Simulation. 
clear;
javaclasspath('/Applications/MATLAB_R2021b.app/toolbox/EV3_Toolbox/EV3');
brick = Brick('ioType','wifi','wfAddr','127.0.0.1','wfPort',5555,'wfSN','0016533dbaf5');

% %Remote Control


% 1 inches is 2.54 cm
INCHES_CONVERSION = 2.54;
%ports number
ULTRASONIC_PORT = 1;
TOUCH_PORT = 4;
COLOR_PORT = 3;
distance = brick.UltrasonicDist(ULTRASONIC_PORT);
direction = "straight";
is_straight = true;
BASE_SPEED = -50;
TURN_SPEED = BASE_SPEED - 10;
color_found = findColor(COLOR_PORT, brick);
% display(distance / INCHES_CONVERSION);
% brick.MoveMotorAngleRel('A',BASE_SPEED,900); %change 900 to however much
% brick.MoveMotorAngleRel('B',BASE_SPEED,900); %change 900 to however much
 
 
% First automatic loop; Will be programmed to break at pickup point (green)
   while color_found ~= "green"
       %color Code Sensor Codes
       %get the color code data and return as string of the color
       theColor = findColor(COLOR_PORT, brick);
       display("The color is " + theColor + ".");
       %todo based on the color string use if statement and update the
       %movement.
  
       % getting touch sensor data
       touch = brick.TouchPressed(TOUCH_PORT);
      
       %if touch sensor is touched, move left
       if (touch == 1)
           %todo movement function needs to be optimized
           brick.StopAllMotors('Brake');
           brick.MoveMotorAngleRel('A',100,900); %change 900 to however much
           brick.MoveMotorAngleRel('B',100,900); %change 900 to however much
           pause(3); %change 3 to however much
           brick.StopAllMotors('Brake');
           brick.MoveMotorAngleRel('A',100,-500,'Brake');
           brick.MoveMotorAngleRel('B',100,500,'Brake');
           pause(1.5);
       else
           wallStatus = wallCorrection(brick, ULTRASONIC_PORT);
           if wallStatus == "right" && is_straight
               brick.MoveMotorAngleRel('A', BASE_SPEED,900); %change 900 to however much
               brick.MoveMotorAngleRel('B',BASE_SPEED,900); %change 900 to however much
               pause(2); %change 2 to however much
               brick.MoveMotorAngleRel('A',TURN_SPEED,500);
               brick.MoveMotorAngleRel('B',-TURN_SPEED,500);
               pause(2);
               brick.MoveMotorAngleRel('A',BASE_SPEED,900); %change 900 to however much
               brick.MoveMotorAngleRel('B',BASE_SPEED,900); %change 900 to however much
               direction = "left";
               is_straight = false;
           elseif wallStatus == "left" && is_straight
               brick.MoveMotorAngleRel('AB',BASE_SPEED,900);
               pause(1);
               brick.MoveMotorAngleRel('A',TURN_SPEED,500);
               brick.MoveMotorAngleRel('B',-TURN_SPEED,500);
               pause(1);
               brick.MoveMotorAngleRel('AB',BASE_SPEED,900);
               direction = "right";
               is_straight = false;
           elseif wallStatus == "straight"
               if direction == "right"
                   brick.MoveMotorAngleRel('A', BASE_SPEED,900); %change 900 to however much
                   brick.MoveMotorAngleRel('B',BASE_SPEED,900); %change 900 to however much
                   pause(2);
                   brick.MoveMotorAngleRel('A',-TURN_SPEED,500);
                   brick.MoveMotorAngleRel('B',TURN_SPEED,500);
                   pause(2);
                   brick.MoveMotorAngleRel('A', BASE_SPEED,900); %change 900 to however much
                   brick.MoveMotorAngleRel('B',BASE_SPEED,900); %change 900 to however much
                   direction = "straight";
                   is_straight = true;
               elseif direction == "left"
                   brick.MoveMotorAngleRel('A', BASE_SPEED,900); %change 900 to however much
                   brick.MoveMotorAngleRel('B',BASE_SPEED,900); %change 900 to however much
                   pause(2); %change 2 to however much
                   brick.MoveMotorAngleRel('A', TURN_SPEED,500);
                   brick.MoveMotorAngleRel('B',-TURN_SPEED,500);
                   pause(2);
                   brick.MoveMotorAngleRel('A', BASE_SPEED,900); %change 900 to however much
                   brick.MoveMotorAngleRel('B',BASE_SPEED,900); %change 900 to however much
                   direction = "straight";
                   is_straight = true;
               else
                   brick.MoveMotorAngleRel('A',BASE_SPEED,900); %change 900 to however much
                   brick.MoveMotorAngleRel('B',BASE_SPEED,900); %change 900 to however much
               end
           elseif wallStatus == "no-wall"
               brick.MoveMotorAngleRel('A', -TURN_SPEED,500);
               brick.MoveMotorAngleRel('B',TURN_SPEED,500);
               pause(2);
               brick.MoveMotorAngleRel('A',BASE_SPEED,900); %change 900 to however much yes
               brick.MoveMotorAngleRel('B',BASE_SPEED,900); %change 900 to however much
               pause(2);
               direction = "right";
               is_straight = false;
           end
           display(wallStatus)
       end
       color_found = findColor(COLOR_PORT, brick);
       pause(0.5)
   end
 

 
%Second automatic loop; works same as first loop, breaks at dropoff(green)
   while color_found ~= "yellow"
       %color Code Sensor Codes
       %get the color code data and return as string of the color
       theColor = findColor(COLOR_PORT, brick);
       display("The color is " + theColor + ".");
       %todo based on the color string use if statement and update the
       %movement.
  
       % getting touch sensor data
       touch = brick.TouchPressed(TOUCH_PORT);
      
       %if touch sensor is touched, move left
       if (touch == 1)
           %todo movement function needs to be optimized
           brick.StopAllMotors('Brake');
           brick.MoveMotorAngleRel('A',100,1080); %change 900 to however much
           brick.MoveMotorAngleRel('B',100,1080); %change 900 to however much
           pause(3) %change 3 to however much
           brick.StopAllMotors('Brake');
           brick.MoveMotorAngleRel('A',100,-500,'Brake');
           brick.MoveMotorAngleRel('B',100,500,'Brake');
           pause(1.5);
       else
           wallStatus = wallCorrection(brick, ULTRASONIC_PORT);
           if wallStatus == "right" && is_straight
               brick.MoveMotorAngleRel('A', BASE_SPEED,900); %change 900 to however much
               brick.MoveMotorAngleRel('B',BASE_SPEED,900); %change 900 to however much
               pause(2); %change 2 to however much
               brick.MoveMotorAngleRel('A',TURN_SPEED,500);
               brick.MoveMotorAngleRel('B',-TURN_SPEED,500);
               pause(2);
               brick.MoveMotorAngleRel('A',BASE_SPEED,900); %change 900 to however much
               brick.MoveMotorAngleRel('B',BASE_SPEED,900); %change 900 to however much
               direction = "left";
               is_straight = false;
           elseif wallStatus == "left" && is_straight
               brick.MoveMotor('AB', BASE_SPEED);
               brick.MoveMotor('A', TURN_SPEED);
               pause(2);
               brick.MoveMotor('AB', BASE_SPEED);
               direction = "right";
               is_straight = false;
           elseif wallStatus == "straight"
               if direction == "right"
                   brick.MoveMotorAngleRel('A', BASE_SPEED,900); %change 900 to however much
                   brick.MoveMotorAngleRel('B',BASE_SPEED,900); %change 900 to however much
                   pause(2);
                   brick.MoveMotorAngleRel('A',-TURN_SPEED,500);
                   brick.MoveMotorAngleRel('B',TURN_SPEED,500);
                   pause(2);
                   brick.MoveMotorAngleRel('A', BASE_SPEED,900); %change 900 to however much
                   brick.MoveMotorAngleRel('B',BASE_SPEED,900); %change 900 to however much
                   direction = "straight";
                   is_straight = true;
               elseif direction == "left"
                   brick.MoveMotorAngleRel('A', BASE_SPEED,900); %change 900 to however much
                   brick.MoveMotorAngleRel('B',BASE_SPEED,900); %change 900 to however much
                   pause(2); %change 2 to however much
                   brick.MoveMotorAngleRel('A', TURN_SPEED,500);
                   brick.MoveMotorAngleRel('B',-TURN_SPEED,500);
                   pause(2);
                   brick.MoveMotorAngleRel('A', BASE_SPEED,900); %change 900 to however much
                   brick.MoveMotorAngleRel('B',BASE_SPEED,900); %change 900 to however much
                   direction = "straight";
                   is_straight = true;
               else
                    brick.MoveMotorAngleRel('A',BASE_SPEED,900); %change 900 to however much
                    brick.MoveMotorAngleRel('B',BASE_SPEED,900); %change 900 to however much
                    direction = "straight";
                    is_straight = true;
               end
           
           end
           display(wallStatus)
       end
       color_found = findColor(COLOR_PORT, brick);
   end
 
   
   
function distance = distanceInches(brick, port)
   INCHES_CONVERSION = 2.54;
   distance = brick.UltrasonicDist(port);
   distance = distance / INCHES_CONVERSION;
end

function result = hasWall(brick, port)
   distance = distanceInches(brick, port);
   result = distance < 24;
end
function result = wallCorrection(brick, port)
   if(~hasWall(brick,port))
       result = "no-wall";
   elseif (distanceInches(brick, port) > 12)
       result = "right";
   elseif (distanceInches(brick, port) < 4)
       result = "left";
   elseif (distanceInches(brick, port) > 4) && (distanceInches(brick, port) < 12)
       result = "straight";
   else
       result = "error";
   end
end
%based on the color sensor data return actual color name as string
function color = findColor(colorPort, brick)
   colorFound = brick.ColorCode(colorPort);
   color = "white";
   switch colorFound
       case 6
           color = "white";
       case 5
           color = "red";
       case 4
           color = "yellow";
       case 3
           color = "green";
   end
end
