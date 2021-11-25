% clear previous connection. Start a new connection with the Simulation. 
clear;
javaclasspath('/Applications/MATLAB_R2021b.app/toolbox/EV3_Toolbox/EV3');
brick = Brick('ioType','wifi','wfAddr','127.0.0.1','wfPort',5555,'wfSN','0016533dbaf5');

% defining the motor ports
MOTOR_LEFT = 'A';
MOTOR_RIGHT = 'B';
TOUCH_PORT = 1;
COLOR_PORT = 3;
ULTRA_PORT = 4;

speed = 50;
turningSpeed = 50;

%color

direction = 'straight';

while 1
    switch direction
        case "straight"
            % move forward 24 inches.
            % update direction variable
            direction = moveForward(brick, speed);
        case "back"
            %go back 12 inches.
            moveBack(brick);
            %update direction based on wall distance
            direction = wallDistance(brick, ULTRA_PORT);
        case "right"
            %turn right function
            %update direction variable
            direction = turnRight(brick, turningSpeed);
        case "left"
            %turn left function
            %update direction variable
            direction = turnLeft(brick, turningSpeed);
        case "stop"
            %stop for 3 seconds.

        case "pickup"
            %pickup passenger.
        case "dropOff"
            %dropoff pessenger. 
    end
end

% move forward 24 inches.
function direction = moveForward(brick, speed)
    while 1
        touch = brick.TouchPressed(1);
        if (touch == 0)
            disp("No Touch");
            %to ensure all motors are at stop
            brick.StopAllMotors('Brake');
            brick.MoveMotor('AB',-speed);
            pause(1);
            brick.StopAllMotors('Brake');
            pause(1);
            %sense color code
            %color = findColor(colorPort, brick);
        else
            disp("touch")
            brick.StopAllMotors('Brake');
            direction = 'back';
            disp(direction);
            break;
        end
    end
end

%go back 12 inches.
function moveBack(brick)
    disp('going back')
    for i = 1:4            
        brick.MoveMotor('AB',100);
        pause(1);
        brick.StopAllMotors('Brake');
        pause(1);
    end
end

%turn left approx 90 degree
function direction = turnRight(brick, turningSpeed)
    pause(2);
    brick.MoveMotorAngleRel('A', turningSpeed,950,'Brake');
    brick.MoveMotorAngleRel('B',-turningSpeed,950,'Brake');
    brick.WaitForMotor('A');
    brick.WaitForMotor('B');
    brick.StopAllMotors('Brake');
    pause(2);
    %update direction variable
    direction = "straight";
end

function direction = turnLeft(brick, turningSpeed)
    pause(2);
    brick.MoveMotorAngleRel('A', -turningSpeed,950,'Brake');
    brick.MoveMotorAngleRel('B',turningSpeed,950,'Brake');
    brick.WaitForMotor('A');
    brick.WaitForMotor('B');
    brick.StopAllMotors('Brake');
    pause(2);
    %update direction variable
    direction = "straight";
end

% function direction = sensorData()
%     %color = findColor(COLOR_PORT);
%     touch = brick.TouchPressed(port);
%     if touch == 0
%         direction = 'straight';
%     else
%         direction = 'back';
%     end


%     distance = wallDistance(ULTR_PORT);
%     % todo what is distance of each square
%     if distance > 24 %so that if the robot is not straght it can also detect wall.
%         direction = right;
%     elseif distance < 24
%         direction = straight;
%     end

%end

% fetch color sensor data
function color = findColor(brick, port)
    color = brick.ColorCode(port);
    switch color
       case 6
           color = "white";
       case 5
           color = "red";
       case 4
           color = "yellow";
       case 3
           color = "green";
    end
    % display color variable for debugging
    disp(color);
end

% function touch = isTouched(port)
%     touch = brick.TouchPressed(port);
%     % display touch variable for debugging.
%     disp(touch);
% end

%measure the distance from the wall in inches.
function direction = wallDistance(brick, port)
    INCHES_CONVERSION = 2.54;
    distance = brick.UltrasonicDist(port);
    distance = distance / INCHES_CONVERSION;
    disp(distance);
    if (distance > 24)
        direction = "right";
    else
        direction = "left";
    end
end