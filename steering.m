%detecting the wall and steering right or left based on the distance from
%the wall.
function [direction,steeringStatus1] = steering(brick, port, steeringStatus)
    distance = wallDistance(brick, port);
    if ((distance < 8) && (steeringStatus == "off"))
        direction = "steerLeft";
        steeringStatus1 = 'left';
    elseif ((distance > 11 && distance < 19) && (steeringStatus == "off"))
        direction = "steerRight";
        steeringStatus1 = 'right';
    elseif ((distance > 9 && distance < 10))
        if (steeringStatus ~= "off")
            if (steeringStatus == "left")    
                direction = "steerRight";
                steeringStatus1 = 'off';
            elseif (steeringStatus == "right")
                direction = "steerLeft";
                steeringStatus1 = "off";
            end
        else
            steeringStatus1 = "off";
            direction = "straight";
        end
    else
        direction = "straight";
        steeringStatus1 = steeringStatus;
    end
end