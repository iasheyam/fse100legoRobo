function direction = sense(brick, TOUCH_PORT, COLOR_PORT, ULTRA_PORT)
        touch = brick.TouchPressed(TOUCH_PORT);        
        if (touch == 0)
            disp("No Touch");
            direction = 'straight';
        else
            direction = 'back';
            disp(direction);
        end
        %sense color code
        color = findColor(brick, COLOR_PORT);
        %update direction based on direction
        if (color == 'green')
            direction = 'dropOff';
        elseif (color == 'yellow')
            direction = 'pickup';
        elseif (color == 'red')
            direction = 'stop';
        end
        
        distance = wallDistance(brick, ULTRA_PORT);
        if (distance > 24)
            direction = "right";
%         elseif (distance < 4)
%             direction = 'steerRight';
%         elseif (direction > 4 && direction < 10)
%             direction = "steerLeft";
        else
            direction = 'left';
        end
end