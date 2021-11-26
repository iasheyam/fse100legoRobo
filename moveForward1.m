function moveForward1(brick, speed)
    brick.StopAllMotors('Brake');
    brick.MoveMotor('AB',-speed);
    pause(1);
    brick.StopAllMotors('Brake');
    pause(1);
end