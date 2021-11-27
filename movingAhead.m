function movingAhead(brick, speed)
    disp('going forward');
    brick.StopAllMotors('Brake');
    brick.MoveMotor('AB',-speed);
    pause(1);
    brick.StopAllMotors('Brake');
    pause(0.5);
end