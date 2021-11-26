function direction = steerRight(brick, turningSpeed)
    %steer right    
    pause(1);
    brick.MoveMotorAngleRel('A', turningSpeed,90,'Brake');
    brick.MoveMotorAngleRel('B',-turningSpeed,90,'Brake');
    brick.WaitForMotor('A');
    brick.WaitForMotor('B');
    brick.StopAllMotors('Brake');
    pause(1);
    
    %go forward
    brick.MoveMotor('AB',-100);
    pause(2);
    brick.StopAllMotors('Brake');
    pause(1);
    
    %steer left
    brick.MoveMotorAngleRel('A', -turningSpeed,90,'Brake');
    brick.MoveMotorAngleRel('B',turningSpeed,90,'Brake');
    brick.WaitForMotor('A');
    brick.WaitForMotor('B');
    brick.StopAllMotors('Brake');
    pause(1);
   
    %update direction variable
    direction = "straight";
end