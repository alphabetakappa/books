      
      
      
      
      
      SUBROUTINE F77WAVE(up, u, um, lambda, a, b, c, nx, ny,
     > dt, dx, dy)
      IMPLICIT LOGICAL (A-Z)
      INTEGER nx, ny
      REAL*8 up(nx,ny), u(nx,ny), um(nx,ny), lambda(nx,ny)
      REAL*8 a, b, c
      REAL*8 dt, dx, dy
      INTEGER i,j

      DO 20 j = 2, ny-1
         DO 10 i = 2, nx-1
            up(i,j) = a*2*u(i,j) - b*um(i,j) +
     > c*(dt*dt)/(dx*dx)* ( 0.5*(lambda(i+1,j )+lambda(i ,j ))*(u(i+1,j 
     &)-u(i ,j )) -0.5*(lambda(i ,j )+lambda(i-1,j ))*(u(i ,j )-u(i-1,j 
     &))) +(dt*dt)/(dy*dy)* ( 0.5*(lambda(i ,j+1)+lambda(i ,j ))*(u(i ,j
     &+1)-u(i ,j )) -0.5*(lambda(i ,j )+lambda(i ,j-1))*(u(i ,j )-u(i ,j
     &-1)))
 10   CONTINUE
 20   CONTINUE

C Boundary points:

      i=1
      DO 30 j = 2, ny-1
         up(i,j) = a*2*u(i,j) - b*um(i,j) +
     > c*(dt*dt)/(dx*dx)* ( 0.5*(lambda(i+1,j )+lambda(i ,j ))*(u(i+1,j 
     &)-u(i ,j )) -0.5*(lambda(i ,j )+lambda(i+1,j ))*(u(i ,j )-u(i+1,j 
     &))) +(dt*dt)/(dy*dy)* ( 0.5*(lambda(i ,j+1)+lambda(i ,j ))*(u(i ,j
     &+1)-u(i ,j )) -0.5*(lambda(i ,j )+lambda(i ,j-1))*(u(i ,j )-u(i ,j
     &-1)))
 30   CONTINUE

      i=nx
      DO 40 j = 2, ny-1
         up(i,j) = a*2*u(i,j) - b*um(i,j) +
     > c*(dt*dt)/(dx*dx)* ( 0.5*(lambda(i-1,j )+lambda(i ,j ))*(u(i-1,j 
     &)-u(i ,j )) -0.5*(lambda(i ,j )+lambda(i-1,j ))*(u(i ,j )-u(i-1,j 
     &))) +(dt*dt)/(dy*dy)* ( 0.5*(lambda(i ,j+1)+lambda(i ,j ))*(u(i ,j
     &+1)-u(i ,j )) -0.5*(lambda(i ,j )+lambda(i ,j-1))*(u(i ,j )-u(i ,j
     &-1)))
 40   CONTINUE

      j=1
      DO 50 i = 2, nx-1
         up(i,j) = a*2*u(i,j) - b*um(i,j) +
     > c*(dt*dt)/(dx*dx)* ( 0.5*(lambda(i+1,j )+lambda(i ,j ))*(u(i+1,j 
     &)-u(i ,j )) -0.5*(lambda(i ,j )+lambda(i-1,j ))*(u(i ,j )-u(i-1,j 
     &))) +(dt*dt)/(dy*dy)* ( 0.5*(lambda(i ,j+1)+lambda(i ,j ))*(u(i ,j
     &+1)-u(i ,j )) -0.5*(lambda(i ,j )+lambda(i ,j+1))*(u(i ,j )-u(i ,j
     &+1)))
 50   CONTINUE

      j=ny
      DO 60 i = 2, nx-1
         up(i,j) = a*2*u(i,j) - b*um(i,j) +
     > c*(dt*dt)/(dx*dx)* ( 0.5*(lambda(i+1,j )+lambda(i ,j ))*(u(i+1,j 
     &)-u(i ,j )) -0.5*(lambda(i ,j )+lambda(i-1,j ))*(u(i ,j )-u(i-1,j 
     &))) +(dt*dt)/(dy*dy)* ( 0.5*(lambda(i ,j-1)+lambda(i ,j ))*(u(i ,j
     &-1)-u(i ,j )) -0.5*(lambda(i ,j )+lambda(i ,j-1))*(u(i ,j )-u(i ,j
     &-1)))
 60   CONTINUE

C Corners:
      i=1
      j=1
      up(i,j) = a*2*u(i,j) - b*um(i,j) +
     > c*(dt*dt)/(dx*dx)* ( 0.5*(lambda(i+1,j )+lambda(i ,j ))*(u(i+1,j 
     &)-u(i ,j )) -0.5*(lambda(i ,j )+lambda(i+1,j ))*(u(i ,j )-u(i+1,j 
     &))) +(dt*dt)/(dy*dy)* ( 0.5*(lambda(i ,j+1)+lambda(i ,j ))*(u(i ,j
     &+1)-u(i ,j )) -0.5*(lambda(i ,j )+lambda(i ,j+1))*(u(i ,j )-u(i ,j
     &+1)))

      i=nx
      j=1
      up(i,j) = a*2*u(i,j) - b*um(i,j) +
     > c*(dt*dt)/(dx*dx)* ( 0.5*(lambda(i-1,j )+lambda(i ,j ))*(u(i-1,j 
     &)-u(i ,j )) -0.5*(lambda(i ,j )+lambda(i-1,j ))*(u(i ,j )-u(i-1,j 
     &))) +(dt*dt)/(dy*dy)* ( 0.5*(lambda(i ,j+1)+lambda(i ,j ))*(u(i ,j
     &+1)-u(i ,j )) -0.5*(lambda(i ,j )+lambda(i ,j+1))*(u(i ,j )-u(i ,j
     &+1)))

      i=1
      j=ny
      up(i,j) = a*2*u(i,j) - b*um(i,j) +
     > c*(dt*dt)/(dx*dx)* ( 0.5*(lambda(i+1,j )+lambda(i ,j ))*(u(i+1,j 
     &)-u(i ,j )) -0.5*(lambda(i ,j )+lambda(i+1,j ))*(u(i ,j )-u(i+1,j 
     &))) +(dt*dt)/(dy*dy)* ( 0.5*(lambda(i ,j-1)+lambda(i ,j ))*(u(i ,j
     &-1)-u(i ,j )) -0.5*(lambda(i ,j )+lambda(i ,j-1))*(u(i ,j )-u(i ,j
     &-1)))

      i=nx
      j=ny
      up(i,j) = a*2*u(i,j) - b*um(i,j) +
     > c*(dt*dt)/(dx*dx)* ( 0.5*(lambda(i-1,j )+lambda(i ,j ))*(u(i-1,j 
     &)-u(i ,j )) -0.5*(lambda(i ,j )+lambda(i-1,j ))*(u(i ,j )-u(i-1,j 
     &))) +(dt*dt)/(dy*dy)* ( 0.5*(lambda(i ,j-1)+lambda(i ,j ))*(u(i ,j
     &-1)-u(i ,j )) -0.5*(lambda(i ,j )+lambda(i ,j-1))*(u(i ,j )-u(i ,j
     &-1)))
      RETURN
      END
