function PR=Iterative(file_in,d,eps)
% Iterative algorithm that determines the PageRank 

 fr=fopen(file_in,'r');
 n=fscanf(fr,'%i',1);
 A=zeros(n,n);
 K=zeros(n,n);

% the adjacency matrix
 for i=1:n

  p=fscanf(fr,'%i',2); % node and number of neighbors
  v=fscanf(fr,'%i',p(2)); % next nr of neighbors 
  v=reshape(v,1,p(2));

   for j=1:p(2)

     A(i,v(1:p(2)))=1; % 1 if the node is in v
     
   endfor

     A(i,i)=0;
  
 endfor


% PR vector

  PR(1:n)=1/n;
   q=histc(A',1); % how many times 1 appears on columns in A'=>how many times appears on rows in A
    K=diag(q); % sets nr of apparitions of 1 on every row on diagonal

	M=(inv(K)*A)';
	one=ones(n,1);
	PR=PR(:);

% compute PR vector until precision

   while (1)
     
     PR1=d*M*PR+(1-d)/n*one;
		 
        if abs(PR1-PR)<eps
			break
		endif
  
     PR=PR1;

   endwhile
	
 fclose(fr);

endfunction



