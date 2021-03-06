function [tz,uz] = rk4(f,t0,u0,tf,h,c)
%
%  [tz,uz] = rk4(f,t0,u0,tf,h,c)
%    
%  Uses 4th order Runge-Kutta method to solve a first order ODE
%    Plots components of solution in Figure #1
%    In 2-D case, also plots phase plane trajectory in Figure #2
%
% Input arguments:
%
%   f  - string name of function on right hand side of ODE: u' = f(t,u)
%            note: f must return a column vector
%   t0 - initial time
%   u0 - initial data u(t0) --- column vector
%   tf - final time or, if vector, list of times to evaluate solution.
%   h  - step size
%
% Optional arguments:
%
%   c  - color for plot
%
% Output:
%
%   tz - times for evaluation of function as specified by tf, or, 
%        if tf is a scalar, all mesh points
%   uz - value of solution at times tz.
%
% See also NUMODE, NEULER, MIDP, IEULER, NEULERF, IEULERF, MIDPF, RK4F
%

[tz,uz] = numode('rk4f',f,t0,u0,tf,h,c);
