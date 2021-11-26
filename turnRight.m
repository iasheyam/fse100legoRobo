%turn right approx 90 degree
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