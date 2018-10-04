function [P,N,C] = Center_Of_Rotation(P,N,W,Pose,C)
T  = compute_transform(Pose,W);
DQ = compute_dualquaternion(Pose,W);
C  = transform_point(T,C,'mat');
P  = C + transform_normal(DQ,P-C,'dq');
N  = transform_normal(DQ,N,'dq');
N  = normr(N);
end