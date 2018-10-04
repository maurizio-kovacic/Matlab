function [DQ] = compute_dualquaternion( T, W )
T = mat2dq(T);
% DQ = W * T;
DQ = zeros(row(W),8);
if(ispoolactive())
    parfor i = 1 : row(W)
        [~,j,w] = find(W(i,:));
        S = sum(T(j(1),:).*T(j,:),2);
        DQ(i,:) = sum( w * ( sign_of(S) .* T(j,:)) , 1 );
    end
else
    for i = 1 : row(W)
        [~,j,w] = find(W(i,:));
        S = sum(T(j(1),:).*T(j,:),2);
        DQ(i,:) = sum( w * ( sign_of(S) .* T(j,:)) , 1 );
    end
end
DQ = normalized_dualquaternion(DQ);
end