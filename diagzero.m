function Y=diagzero(X)
 N=size(X);
 if N(1)~=N(2)
 error(' Matrix not square');
 end
 Y=X;
 for x=1:N(1)
   Y(x,x)=0;
 end