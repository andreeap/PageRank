function tema2(file_in,d,eps)


 fr=fopen(file_in,'r'); 
 n=fscanf(fr,'%i',1);

 %read all lines until n+1
 for i=1:n+1;
  q=fgetl(fr);
 endfor
 
 %read the last two values from the file
 val1=fscanf(fr,'%f',1); 
 val2=fscanf(fr,'%f',1);

 fclose(fr);

 %call Iterative.m and Algebraic.m
 PRi=Iterative(file_in,d,eps);
 PRa=Algebraic(file_in,d);

  u=zeros(1,n);%array with the values of the function
  u=u(:);
  s=zeros(1,n);
  s=s(:);

%compute a and b for u to be continuous
 a=1/(val2-val1);
 b=-(val1/(val2-val1));
 for i=1:n
  if 0<=PRa(i) && PRa(i)<val1  
    u(i)=0;
  elseif val1<=PRa(i) && PRa(i)<=val2
    u(i)=a*PRa(i)+b;
  else
    u(i)=1;
 endif
endfor

for i=1:n 
  s(i)=i;
endfor

%sort PRa vector
 for i=1:n-1
   for j=i+1:n  
       if u(i)<u(j)
         aux=u(i);
          u(i)=u(j);
          u(j)=aux;
          aux=s(i);
		  s(i)=s(j);
		  s(j)=aux;
        endif
    endfor
  endfor
    
%write the results to a file
 file_out=strcat(file_in,'.out');
	
	fw=fopen(file_out,'w');
	fprintf(fw,'%i\n\n',n);
	fprintf(fw,'%f\n',PRi);
	fprintf(fw,'\n');
	fprintf(fw,'%f\n',PRa);
	fprintf(fw,'\n');
	for i=1:n
	 fprintf(fw,'%i %i %f\n',i,s(i),u(i));
	endfor
	
	fclose(fw);

endfunction


