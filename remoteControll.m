% manual remote control mode
function direction = remoteControll(brick)
    global key
    InitKeyboard();
    while 1
        pause(0.1);
        switch key
            case 'uparrow' %makes robot move forwards
                brick.MoveMotorAngleRel('A',-100,1900,'Brake');
                brick.MoveMotorAngleRel('B',-100,1900,'Brake');

            case 'downarrow' %makes robot move backwards
                brick.MoveMotorAngleRel('A',100,1900,'Brake');
                brick.MoveMotorAngleRel('B',100,1900,'Brake');

            case 'rightarrow' %makes robot turn right
                brick.MoveMotorAngleRel('A',100,500,'Brake');
                brick.MoveMotorAngleRel('B',100,-500,'Brake');

            case 'd' %makes robot turn 90 degrees right
                brick.MoveMotorAngleRel('A',100,500,'Brake');
                brick.MoveMotorAngleRel('B',100,-500,'Brake');
                pause(1.5);

            case 'leftarrow' %makes robot turn left
                brick.MoveMotorAngleRel('A',100,-500,'Brake');
                brick.MoveMotorAngleRel('B',100,500,'Brake');

            case 'a' %makes robot turn 90 degrees left
                brick.MoveMotorAngleRel('A',100,-500,'Brake');
                brick.MoveMotorAngleRel('B',100,500,'Brake');
                pause(1.5);

            case 'z'
                brick.MoveMotorAngleRel('C',50,-10,'Coast');
            case 'x'
                brick.MoveMotorAngleRel('C',50,10,'Coast');

            case 'm'
                brick.playTone(75,440,100);
                pause(0.2);
                brick.playTone(75,466,100);
                pause(0.2);
                brick.playTone(75,523,100);
                pause(0.2);
                brick.playTone(75,587,750);

            case 'v'
                brick.playTone(75,523,250);
                pause(0.2);
                brick.playTone(75,523,250);
                pause(0.2);
                brick.playTone(75,523,250);
                pause(0.25);
                brick.playTone(75,523,500);
                pause(0.25);
                brick.playTone(75,415,500);
                pause(0.3);
                brick.playTone(75,466,500);
                pause(0.25);
                brick.playTone(75,523,500);
                pause(0.3);
                brick.playTone(75,466,500);
                pause(0.1);
                brick.playTone(75,523,1000);
            case 0
                brick.StopAllMotors('Coast');
            case 'q'
                direction = 'straight'
                break;
        end
    end
end