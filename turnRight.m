%turn right approx 90 degree
function direction = turnRight(brick, turningSpeed)
    disp('turning right');
    pause(2);
    brick.StopAllMotors('Brake');
    brick.WaitForMotor('A');
    brick.WaitForMotor('B');
    brick.MoveMotorAngleRel('A', turningSpeed,1000);
    brick.MoveMotorAngleRel('B',-turningSpeed,1000);
    brick.WaitForMotor('A');
    brick.WaitForMotor('B');
    pause(5);
    disp('turning right complete');
    %update direction variable    
    direction = "straight";
end