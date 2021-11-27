function direction = turnLeft(brick, turningSpeed)
    disp('turning left');
    pause(2);
    brick.StopAllMotors('Brake');
    brick.WaitForMotor('A');
    brick.WaitForMotor('B');
    brick.MoveMotorAngleRel('A', -turningSpeed,1000);
    brick.MoveMotorAngleRel('B',turningSpeed,1000);
    brick.WaitForMotor('A');
    brick.WaitForMotor('B');
    pause(4);
    disp('turning left complete');
    %update direction variable
    direction = "straight";
end