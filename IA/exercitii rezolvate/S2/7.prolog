% X este Y--.
% pune in X valoarea decrementata cu 1 a lui Y
:- op(100, xf, --).
:- op(200, xfy, este).

X este Y-- :- X is Y-1. 

% apelul se face astfel:
% ?- (X este 3--).
