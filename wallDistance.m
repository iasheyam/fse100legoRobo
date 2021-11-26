%measure the distance from the wall in inches.
function distance = wallDistance(brick, port)
    INCHES_CONVERSION = 2.54;
    distance = brick.UltrasonicDist(port);
    distance = distance / INCHES_CONVERSION;
    disp(distance);
end