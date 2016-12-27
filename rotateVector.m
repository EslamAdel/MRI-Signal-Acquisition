function newVector = rotateVector (vector, angle, rotationAxis)
%% newVector = rotateVector (vector, angle, rotationAxis)
% Rotate a 3D vector around X, Y, or Z axis conuter clock wise by a 
% specific angle.
% inputs : 
%
% vector : A 3D vector of size 3x1 to be rotated 
%
% angle : the rotation angle deg.
% 
% rotationAxis : the rotation axis 'X', 'Y', or 'Z' are only the valid
%                parameters for this variable.
%
% output : 
% newVector : the vector after rotation.
% 
% example : 
%   x = [1; 0; 0];
%   rotateVector(x, 90, 'Z')
%
% Author : 
% Eslam Mahmoud <eslam.adel.mahmoud.ali@gmail.com>


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
