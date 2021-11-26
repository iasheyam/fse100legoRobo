function direction = steering(brick, port)
    distance = wallDistance(brick, port);
    if (distance < 6)
        direction = "steerLeft";
        disp("steering left");
    elseif (distance > 14 && distance < 24)
        direction = "steerRight";
        disp("steering right");
    else
        direction = "straight";
    end

end