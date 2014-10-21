function PR=Algebraic(file_in,d)
% Algebraic algorithm that determines the PageRank

 fr=fopen(file_in,'r'); 
 n=fscanf(fr,'%i',1); 
 A=zeros(n,n);
 K=zeros(n,n);

% the adjacency matrix
% inverse K, where K is a diagonal matrix
  for i=1:n
     p = fscanf( fr , '%i' , 2 ); % node and number of neighbors
     v = fscanf( fr , '%i' , p(2) ); % next nr of neighbors
     v = reshape( v , 1 , p(2) );

      for j = 1 : p(2) 
       A( i, v(1:p(2)) )=1; % 1 if the node is in v    
      endfor
   
     A(i,i) = 0;
  endfor

    
    q = histc( A' , 1 ); % how many times 1 appears on columns in A'=>how many times appears on rows in A
    K = diag(q); % sets nr of apparitions of 1 on every row on diagonal
    K = diag( 1 ./ diag(K) ); % inverse K
    M = ( K * A )';
    Id = eye(n) - d * M;

% compute Id with Gram-Schimdt / Id=QR
	[m,n]=size(Id);
	R=zeros(m,n);
	Q=eye(m);
	for i = 1 : n
		R( 1 : i-1, i ) = Q( 1 : m, 1 : i-1 )'*Id( 1 : m, i );
		y = Id( 1 : m, i ) - Q( 1 : m, 1 : i-1 )*R( 1 : i-1, i );
		R( i, i ) = norm( y );
		Q( 1 : m, i ) = y ./ R( i, i );
	endfor



   Idv=zeros(n); % inverse of Id

  % inverse R
  % Input: R=upper triangular matrix
  % Output: Ri = inverse R
   [n, n] = size(R);
   for j = n : -1 : 1
        Ri(j, j) = 1 / R(j, j);
      for i = j - 1 : -1 : 1 
         Ri(i,j)=-R(i,i+1:j)*Ri(i+1:j,j)/R(i,i);
      endfor
   endfor
   Ri = triu(Ri);

  Idv=Ri*Q';

  PR=zeros(1,n)
  PR=PR(:);
  PR=Idv*((1-d)/n)*ones(n,1);

  fclose(fr);

 endfunction
