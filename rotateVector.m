## Copyright (C) 2016 eslam
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{newVector} =} rotateVector (@var{vector}, @var{anlge}, @var{Axis})
## rotates a 3D vector around rotation Axis(X, Y, or Z) by a specific angle
## @itemize @bullet
## @item
## @var{vector} : may be one vector of size(3x1) or many vector organized in a matrix of size(3 x m)
## where m is the number of vectors.
## @item
## @var{angle} : the rotation angle in degree.
## @item
## @var{Axis} : rotation axis X, Y, or Z only.
## @item
## Example 
## @example
## x = [0; 0; 1];
## rotateVector(x, 90, 'X')
## ans =
##   0.00000
##   1.00000
##   0.00000
##
## Rotate multi vectros 
## y = [ 1 0 0; 0 1 0; 0 0 1]';
## rotateVector(y, 180, 'Z')
## ans =
##  -1.00000   0.00000   0.00000
##  -0.00000  -1.00000   0.00000
##   0.00000   0.00000   1.00000
## @end deftypefn

## Author: eslam <eslam.adel.mahmoud.ali@gmail.com>
## Created: 2016-10-08

## @end example
##

## @end deftypefn

## Author: eslam <eslam@eslam-G1-Sniper-Z87>
## Created: 2016-10-08

function newVector = rotateVector (vector, angle, rotationAxis)

%Convert rotation angle to radian
angle = angle * pi / 180;

%Initialize the rotated vector
newVector = zeros(3,1);

%Initialize final rotaion matrix
rotationMatrix = zeros(3);

%Build X rotation Matrix
Rx = [1               0               0       ; ...
      0           cos(angle)      sin(angle)  ; ...
      0           -sin(angle)     cos(angle)] ;
      
%Build Y rotaion matrix
Ry = [cos(angle)      0          -sin(angle)  ; ...
         0            1                0      ; ...
      sin(angle)      0           cos(angle)] ;

%Build Z rotation matrix
Rz = [ cos(angle)        sin(angle)       0   ; ...
      -sin(angle)        cos(angle)       0   ; ...
          0                 0             1 ] ;

%Select desired rotation matrix
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

%Calculate the rotation result
try
newVector = rotationMatrix * vector;
catch 
error('Vector must be a 3D vector');
end

end
