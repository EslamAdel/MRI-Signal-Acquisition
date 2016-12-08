function newVector = rotateVector (vector, angle, rotationAxis)
%% Convert rotation angle to radian
angle = angle * pi / 180;

%% Build X rotation Matrix
Rx = [1               0               0       ; ...
      0           cos(angle)      sin(angle)  ; ...
      0           -sin(angle)     cos(angle)] ;
      
%% Build Y rotaion matrix
Ry = [cos(angle)      0          -sin(angle)  ; ...
         0            1                0      ; ...
      sin(angle)      0           cos(angle)] ;

%% Build Z rotation matrix
Rz = [ cos(angle)        sin(angle)       0   ; ...
      -sin(angle)        cos(angle)       0   ; ...
          0                 0             1 ] ;

%% Select desired rotation matrix
switch(rotationAxis)
  case 'X'
    rotationMatrix = Rx; 

  case 'Y'
    rotationMatrix = Ry;
  
  case 'Z'
    rotationMatrix = Rz;
  otherwise
  error('Not Supported');
end

%% Calculate the rotation result
newVector = rotationMatrix * vector;
end
