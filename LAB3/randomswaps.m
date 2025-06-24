%% Function to swap indices randomly

function swapped_matrix = randomswaps(M)

%%% Input: a binary matrix M
%%% Output: randomly swap a 1 and 0 in the binary matrix and output the
%%% generated matrix

        % Randomly select an index with entry 1 and then randomly select
        % another index with entry 0.
        % return the swapped matrix
        % Hint: Use find() and randi()

        % return the swapped matrix

x1=find(M==1);
sz1=length(x1);
x2=find(M==0);
sz2=length(x2);
r1=x1(randi(sz1));
r2=x2(randi(sz2));
temp=M(r1);
M(r1)=M(r2);
M(r2)=temp;
swapped_matrix = M;

end