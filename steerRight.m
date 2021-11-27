function direction = steerRight(brick, turningSpeed, TOUCH_PORT, ULTRA_PORT)
    %steer right
    pause(1);
    brick.MoveMotorAngleRel('A', turningSpeed,180);
    brick.MoveMotorAngleRel('B',-turningSpeed,180);
    brick.WaitForMotor('A');
    brick.WaitForMotor('B');
    pause(2);
 
%         %steer left
%         disp("steering right");
%         pause(1);
%         brick.MoveMotorAngleRel('A', -turningSpeed,180);
%         brick.MoveMotorAngleRel('B',turningSpeed,180);
%         brick.WaitForMotor('A');
%         brick.WaitForMotor('B');
%         pause(1);
%         turned = 0
   
    %update direction variable
    direction = "straight";
end