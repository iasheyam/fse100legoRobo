function direction = turning(brick, port)
    distance = wallDistance(brick, port);
    if (distance > 24)
        direction = "right";
    else
        direction = "left";
    end
end