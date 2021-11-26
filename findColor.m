% fetch color sensor data
function color = findColor(brick, port)
    color = brick.ColorCode(port);
    switch color
       case 6
           color = "white";
       case 5
           color = "red";
       case 4
           color = "yellow";
       case 3
           color = "green";
    end
    % display color variable for debugging
    disp(color);
end