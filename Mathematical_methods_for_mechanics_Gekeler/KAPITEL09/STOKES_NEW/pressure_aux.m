function [SE,PP1,PP2,AU,BU,CV,DV,BE_Q,ME] = pressure_aux(X,Y,U,V)
% Supplies element matrices
% for post processor for pressure after Sohn

% INPUT:
% X,Y Coordinates of the three vertices
% ecode = 1 for wrong orientation

ecode = 0;
S1 = [3   1   0  -4   0   0;
      1   3   0  -4   0   0;
      0   0   0   0   0   0;
     -4  -4   0   8   0   0;
      0   0   0   0   8  -8;
      0   0   0   0  -8   8];
S2 = [6   1   1  -4   0  -4;
      1   0  -1  -4   4   0;
      1  -1   0   0   4  -4;
     -4  -4   0   8  -8   8;
      0   4   4  -8   8  -8;
     -4   0  -4   8  -8   8];
S3 = [3   0   1   0   0  -4;
      0   0   0   0   0   0;
      1   0   3   0   0  -4;
      0   0   0   8  -8   0;
      0   0   0  -8   8   0;
     -4   0  -4   0   0   8];
     
S4 = [6  -1  -1   0  -4   0;
     -1   6  -1   0   0  -4;
     -1  -1   6  -4   0   0;
      0   0  -4  32  16  16;
     -4   0   0  16  32  16;
      0  -4   0  16  16  32];
     
SB = [0;  0;  0;  1;  1;  1];

int_qx_uxx = ...
[  -2,  -2,   0,   4,   0,   0;
   2,   2,   0,  -4,   0,   0;
   0,   0,   0,   0,   0,   0;
   0,   0,   0,   0,   0,   0;
   8,   8,   0, -16,   0,   0;
  -8,  -8,   0,  16,   0,   0]/3;
int_qx_uxy = ...
[-2,  0,  0,  2, -2,  2;
  2,  0,  0, -2,  2, -2;
  0,  0,  0,  0,  0,  0;
  0,  0,  0,  0,  0,  0;
  8,  0,  0, -8,  8, -8;
 -8,  0,  0,  8, -8,  8]/3;
int_qx_uyy = ...
[  -2,   0,  -2,   0,   0,   4;
   2,   0,   2,   0,   0,  -4;
   0,   0,   0,   0,   0,   0;
   0,   0,   0,   0,   0,   0;
   8,   0,   8,   0,   0, -16;
  -8,   0,  -8,   0,   0,  16]/3;
int_qy_uxx = ...
[  -2,  -2,   0,   4,   0,   0;
   0,   0,   0,   0,   0,   0;
   2,   2,   0,  -4,   0,   0;
  -8,  -8,   0,  16,   0,   0;
   8,   8,   0, -16,   0,   0;
   0,   0,   0,   0,   0,   0]/3;
int_qy_uxy = ...
[ -2,  0,  0,  2, -2,  2;
  0,  0,  0,  0,  0,  0;
  2,  0,  0, -2,  2, -2;
 -8,  0,  0,  8, -8,  8;
  8,  0,  0, -8,  8, -8;
  0,  0,  0,  0,  0,  0]/3;
int_qy_uyy = ...
[  -2,   0,  -2,   0,   0,   4;
   0,   0,   0,   0,   0,   0;
   2,   0,   2,   0,   0,  -4;
  -8,   0,  -8,   0,   0,  16;
   8,   0,   8,   0,   0, -16;
   0,   0,   0,   0,   0,   0]/3;
% -----------------------------------------   
int_qx_u = ...
[ -2,  1,  1, -3,  1, -3;
 -1,  2, -1,  3,  3, -1;
  0,  0,  0,  0,  0,  0;
  3, -3,  0,  0, -4,  4;
 -1, -1,  2,  4,  8,  8;
  1,  1, -2, -4, -8, -8]/30;
int_x_qx_u = ...
[  -3,   6,   1,  -8,   8,  -4;
  -5,  18,  -5,  24,  24,   4;
   0,   0,   0,   0,   0,   0;
   8, -24,   4, -16, -32,   0;
  -4,   0,   0,  16,  32,  16;
   4,   0,   0, -16, -32, -16]/360;
int_y_qx_u = ...
[  -3,   1,   6,  -4,   8,  -8;
  -1,   3,  -6,   4,   8,  -8;
   0,   0,   0,   0,   0,   0;
   4,  -4,   0,   0, -16,  16;
  -8,  -8,  24,  16,  48,  48;
   8,   8, -24, -16, -48, -48]/360;
   
int_qy_u = ...
[ -2,  1,  1, -3,  1, -3;
  0,  0,  0,  0,  0,  0;
 -1, -1,  2, -1,  3,  3;
  1, -2,  1, -8, -8, -4;
 -1,  2, -1,  8,  8,  4;
  3,  0, -3,  4, -4,  0]/30;
int_x_qy_u = ...
[  -3,   6,   1,  -8,   8,  -4;
   0,   0,   0,   0,   0,   0;
  -1,  -6,   3,  -8,   8,   4;
   8, -24,   8, -48, -48, -16;
  -8,  24,  -8,  48,  48,  16;
   4,   0,  -4,  16, -16,   0]/360;
   
int_y_qy_u = ...
[  -3,   1,   6,  -4,   8,  -8;
   0,   0,   0,   0,   0,   0;
  -5,  -5,  18,   4,  24,  24;
   4,   0,   0, -16, -32, -16;
  -4,   0,   0,  16,  32,  16;
   8,   4, -24,   0, -32, -16]/360;

X21 = X(2) - X(1); X32 = X(3) - X(2); X31 = X(3) - X(1); X13 = - X31;
Y21 = Y(2) - Y(1); Y32 = X(3) - X(2); Y31 = Y(3) - Y(1); Y12 = - Y21;
Y13 = - Y31;
DET = X21*Y31 - X31*Y21;
if DET > 0
   % stiffness matrix
   A  =  (X31*X31 + Y31*Y31)/DET;
   B  = -(X31*X21 + Y31*Y21)/DET;
   C  =  (X21*X21 + Y21*Y21)/DET;
   SE =  (A*S1 + B*S2 + C*S3)/6; % stiffness matrix
   ME = DET*S4/360;
   % diffusion term
   A = Y31^2 + X13^2; B = 2*(Y31*Y12 + X13*X21); C = Y12^2 + X21^2;
   a = Y31*A/DET^2; b = Y31*B/DET^2; c = Y31*C/DET^2;
   d = Y12*A/DET^2; e = Y12*B/DET^2; f = Y12*C/DET^2;
PP1 = a*int_qx_uxx + b*int_qx_uxy + c*int_qx_uyy ...
   + d*int_qy_uxx + e*int_qy_uxy + f*int_qy_uyy;
  
   a = X13*A/DET^2; b = X13*B/DET^2; c = X13*C/DET^2;
   d = X21*A/DET^2; e = X21*B/DET^2; f = X21*C/DET^2;
PP2 = a*int_qx_uxx + b*int_qx_uxy + c*int_qx_uyy ...
   + d*int_qy_uxx + e*int_qy_uxy + f*int_qy_uyy;
  
%P = PP1*U + PP2*V; % Diffusionsteil int_T(nabla q * Delta u)dxdy

% convection term

M1 = Y31*int_qx_u   + Y12*int_qy_u;
P1 = Y31*int_x_qx_u + Y12*int_x_qy_u;
Q1 = Y31*int_y_qx_u + Y12*int_y_qy_u;

M2 = X13*int_qx_u   + X21*int_qy_u;
P2 = X13*int_x_qx_u + X21*int_x_qy_u;
Q2 = X13*int_y_qx_u + X21*int_y_qy_u;

PX = [-3,-1, 0, 4,0, 0;  % Data of DPsi/Dxi
       4, 4, 0,-8,0, 0;
       4, 0, 0,-4,4,-4];

PY = [-3, 0,-1, 0,0, 4;  % Data of DPsi/Deta
       4, 0, 0,-4,4,-4;
       4, 0, 4, 0,0,-8];
       
F = (PX*Y31 + PY*Y12)/DET; G = (PX*X13 + PY*X21)/DET;

AU = F(1,:)*U*M1 + F(2,:)*U*P1 + F(3,:)*U*Q1;
BU = G(1,:)*U*M1 + G(2,:)*U*P1 + G(3,:)*U*Q1;
CV = F(1,:)*V*M2 + F(2,:)*V*P2 + F(3,:)*V*Q2;
DV = G(1,:)*V*M2 + G(2,:)*V*P2 + G(3,:)*V*Q2;

% Q = AU*U + BU*V + CV*U + DV*V; int_T grad q * [grad u] u dxdy
   
BE_Q =  DET*SB/6;   % load vector for quadratic elements
 
else ecode = 1; return    
end
