%GETNEXTCLIQUES Find a pair of cliques ready for message passing
%   [i, j] = GETNEXTCLIQUES(P, messages) finds ready cliques in a given
%   clique tree, P, and a matrix of current messages. Returns indices i and j
%   such that clique i is ready to transmit a message to clique j.
%
%   We are doing clique tree message passing, so
%   do not return (i,j) if clique i has already passed a message to clique j.
%
%	 messages is a n x n matrix of passed messages, where messages(i,j)
% 	 represents the message going from clique i to clique j. 
%   This matrix is initialized in CliqueTreeCalibrate as such:
%      MESSAGES = repmat(struct('var', [], 'card', [], 'val', []), N, N);
%
%   If more than one message is ready to be transmitted, return 
%   the pair (i,j) that is numerically smallest. If you use an outer
%   for loop over i and an inner for loop over j, breaking when you find a 
%   ready pair of cliques, you will get the right answer.
%
%   If no such cliques exist, returns i = j = 0.
%
%   See also CLIQUETREECALIBRATE
%
% Copyright (C) Daphne Koller, Stanford University, 2012


function [idx, jdx] = GetNextCliques(P, messages)

% initialization
% you should set them to the correct values in your code
idx = 0;
jdx = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

edges = P.edges;
cliqueList = P.cliqueList;
N = length(cliqueList);

for i=1:N,
	adj_i = find(edges(i, :)==1);
	%disp(adj_i);
	for j = 1:length(adj_i),
		if isempty(messages(i, adj_i(j)).var),
			satisfy = true;
			for k = 1:length(adj_i),
				if k ~= j && isempty(messages(adj_i(k), i).var),
					satisfy=false;
					break;
				end;
			end;

			if satisfy,
				idx = i;
				jdx = adj_i(j);
				return;
			end;

		end;

	end;

end;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



return;
