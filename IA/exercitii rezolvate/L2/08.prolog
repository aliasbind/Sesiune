% multimi1(+AUB, +AIB, +AMB, -A, -B)
% determina A, B din reuniunea, intersectia si diferenta lor

multimi1(AUB, AIB, AMB, A, B) :- append(AMB, AIB, A), subtract(AUB, A, B1),
                                 append(AIB, B1, B).
