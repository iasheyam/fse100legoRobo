% move forward 24 inches.
function direction = moveForward(brick, speed, COLOR_PORT)
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
            color = findColor(brick, COLOR_PORT);
            %update direction based on direction
            if (color == 'green')
                direction = 'dropOff';
                break;
            elseif (color == 'yellow')
                direction = 'pickup';
                break;
            elseif (color == 'red')
                direction = 'stop';
                break;
            end
        else
            disp("touch")
            brick.StopAllMotors('Brake');
            direction = 'back';
            disp(direction);
            break;
        end
    end
end