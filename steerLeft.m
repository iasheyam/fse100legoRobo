function direction = steerLeft(brick, turningSpeed, TOUCH_PORT, ULTRA_PORT)
    %steer left    
    disp("steering left");
    pause(1);
    brick.MoveMotorAngleRel('A', -turningSpeed,180);
    brick.MoveMotorAngleRel('B',turningSpeed,180);
    brick.WaitForMotor('A');
    brick.WaitForMotor('B');
    pause(2);
    
%     while 1
%         % touch is required so that steering doesn't work when touched
%         touch = brick.TouchPressed(TOUCH_PORT);
%         distance = wallDistance(brick, ULTRA_PORT);
%         disp(touch);
%         disp(distance);
%         %since this instance the distance is measured in angel
%         if ((touch == 0) && (distance < 8))
%             %go forward
%             brick.MoveMotor('AB',-100);
%             pause(1);
%             brick.StopAllMotors('Brake');
%         else
%             break;
%         end
%     end
%     
%     %steer right
%     pause(1);
%     brick.MoveMotorAngleRel('A', turningSpeed,180);
%     brick.MoveMotorAngleRel('B',-turningSpeed,180);
%     brick.WaitForMotor('A');
%     brick.WaitForMotor('B');
%     pause(1);
   
    %update direction variable
    direction = "straight";
end