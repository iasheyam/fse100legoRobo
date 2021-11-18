% 1 inches is 2.54 cm
INCHES_CONVERSION = 2.54;
%ports number
ULTRASONIC_PORT = 4;
TOUCH_PORT = 1;
COLOR_PORT = 3;
distance = brick.UltrasonicDist(ULTRASONIC_PORT);
direction = "straight";
is_straight = true;
BASE_SPEED = -70;
TURN_SPEED = BASE_SPEED + 10;
color_found = findColor(COLOR_PORT, brick);
% display(distance / INCHES_CONVERSION);
brick.MoveMotorAngleRel('A',BASE_SPEED,360); %change 360 to however much
brick.MoveMotorAngleRel('B',BASE_SPEED,360); %change 360 to however much
  
 
% First automatic loop; Will be programmed to break at pickup point (green)
   while 1
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
           pause(1);
           brick.MoveMotorAngleRel('AB',100,360); %change 360 to however much
           pause(1); %change 3 to however much
           brick.StopAllMotors('Brake');
           pause(1);
           brick.MoveMotorAngleRel('A',100,-950,'Brake');
           brick.MoveMotorAngleRel('B',100,950,'Brake');
           pause(1);
       else
           wallStatus = wallCorrection(brick, ULTRASONIC_PORT);
           if wallStatus == "right" && is_straight
               brick.MoveMotorAngleRel('AB',BASE_SPEED,360); %change 360 to however much
               pause(1); %change 2 to however much
               brick.MoveMotorAngleRel('A',TURN_SPEED,950);
               brick.MoveMotorAngleRel('B',-TURN_SPEED,950);
               pause(2);
               brick.MoveMotorAngleRel('AB',BASE_SPEED,360); %change 360 to however much
               direction = "left";
               is_straight = false;
           elseif wallStatus == "left" && is_straight
               brick.MoveMotorAngleRel('AB',BASE_SPEED,360);
               pause(1);
               brick.MoveMotorAngleRel('A',TURN_SPEED,950);
               brick.MoveMotorAngleRel('B',-TURN_SPEED,950);
               pause(2);
               brick.MoveMotor('AB', BASE_SPEED);
               direction = "right";
               is_straight = false;
           elseif wallStatus == "straight"
               if direction == "right"
                   brick.MoveMotorAngleRel('A', BASE_SPEED,360); %change 360 to however much
                   brick.MoveMotorAngleRel('B',BASE_SPEED,360); %change 360 to however much
                   pause(2);
                   brick.MoveMotorAngleRel('A',-TURN_SPEED,950);
                   brick.MoveMotorAngleRel('B',TURN_SPEED,950);
                   pause(2);
                   brick.MoveMotorAngleRel('A', BASE_SPEED,360); %change 360 to however much
                   brick.MoveMotorAngleRel('B',BASE_SPEED,360); %change 360 to however much
                   direction = "straight";
                   is_straight = true;
               elseif direction == "left"
                   brick.MoveMotorAngleRel('A', BASE_SPEED,360); %change 360 to however much
                   brick.MoveMotorAngleRel('B',BASE_SPEED,360); %change 360 to however much
                   pause(2); %change 2 to however much
                   brick.MoveMotorAngleRel('A', TURN_SPEED,950);
                   brick.MoveMotorAngleRel('B',-TURN_SPEED,950);
                   pause(2);
                   brick.MoveMotorAngleRel('A', BASE_SPEED,360); %change 360 to however much
                   brick.MoveMotorAngleRel('B',BASE_SPEED,360); %change 360 to however much
                   direction = "straight";
                   is_straight = true;
                   else
                       brick.MoveMotorAngleRel('A',BASE_SPEED,360);
                       brick.MoveMotorAngleRel('B',BASE_SPEED,360);
                       direction = "straight";
                       is_straight = true;
               end
           end
           display(wallStatus)
       end
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


