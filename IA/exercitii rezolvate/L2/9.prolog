% multimi2(+AIB, +AMB, +BMA, -A, -B)
% determina A, B din intersectia si diferentele lor

multimi2(AIB, AMB, BMA, A, B) :- append(AMB, AIB, A), append(BMA, AIB, B).
