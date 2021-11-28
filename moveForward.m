% move forward 24 inches.
function [direction, steeringStatus1] = moveForward(brick, speed, COLOR_PORT, ULTRA_PORT, steeringStatus)
    while 1
        touch = brick.TouchPressed(1);
        if (touch == 0)
            disp("No Touch");
            %to ensure all motors are at stop
            %sense color code
            color = findColor(brick, COLOR_PORT);
            %update direction based on direction
            if (color == "green")
                direction = "dropOff";
                steeringStatus1 = steeringStatus;
                break;
            elseif (color == "yellow")
                direction = 'pickup';
                steeringStatus1 = steeringStatus;
                break;
            elseif (color == "red")
                direction = 'stop';
                steeringStatus1 = steeringStatus;
                break;
            end
            movingAhead(brick, speed);
            [direction, steeringStatus1] = steering(brick, ULTRA_PORT, steeringStatus);
            steeringStatus = steeringStatus1;
            if (direction ~= "straight")
                break;
            end

        else
            disp("touch")
            brick.StopAllMotors('Brake');
            direction = 'back';
            steeringStatus1 = steeringStatus;
            break;
        end
    end
end