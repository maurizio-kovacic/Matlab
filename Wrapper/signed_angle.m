function [theta] = signed_angle(A,B,N)
theta = angle(A,B) .* sign_of(dotN(N,cross(A,B,2)));
end