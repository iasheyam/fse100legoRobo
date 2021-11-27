% clear previous connection. Start a new connection with the Simulation. 
clear;
javaclasspath('/Applications/MATLAB_R2021b.app/toolbox/EV3_Toolbox/EV3');
brick = Brick('ioType','wifi','wfAddr','127.0.0.1','wfPort',5555,'wfSN','0016533dbaf5');

% defining the ports
MOTOR_LEFT = 'A';
MOTOR_RIGHT = 'B';
TOUCH_PORT = 1;
COLOR_PORT = 3;
ULTRA_PORT = 4;

speed = 100;
turningSpeed = 50;

direction = 'straight';
steeringStatus = "off";

while 1
    switch direction
        case "straight"
            % move forward 24 inches.
            % update direction variable based on sensors.
            [direction,steeringStatus1] = moveForward(brick, speed, COLOR_PORT, ULTRA_PORT, steeringStatus);
            steeringStatus = steeringStatus1;
        case "back"
            %go back 12 inches.
            moveBack(brick);
            %update direction based on wall distance
            direction = turning(brick, ULTRA_PORT);
        case "right"
            %turn right function
            %update direction variable
            direction = turnRight(brick, turningSpeed);
        case "left"
            %turn left function
            %update direction variable
            direction = turnLeft(brick, turningSpeed);
        case "steerRight"
            direction = steerRight(brick, turningSpeed, TOUCH_PORT, ULTRA_PORT);
        case "steerLeft"
            direction = steerLeft(brick, turningSpeed, TOUCH_PORT, ULTRA_PORT);
        case "stop"
            %stop for 3 seconds.
            brick.StopAllMotors('Brake');
            pause(3);
            movingAhead(brick, speed);            
            direction = 'straight';
        case "pickup"
            % starting remote control in pickupzone
            direction = remoteControll(brick);
        case "dropOff"
            direction = remoteControll(brick);
    end
end