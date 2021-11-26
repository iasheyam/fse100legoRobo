%go back 12 inches.
function moveBack(brick)
    disp('going back')
    for i = 1:4            
        brick.MoveMotor('AB',100);
        pause(1);
        brick.StopAllMotors('Brake');
        pause(1);
    end
end