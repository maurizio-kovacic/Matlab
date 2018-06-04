function [ V ] = valence( P, T )
A = Adjacency( P, T, 'comb' );
V = full(sum(A,2));
end