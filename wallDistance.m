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