clear all
clc
tic;
load citys_data.mat

n = size(citys,1);
D = zeros(n,n);

%% Compute distance matrix
for i = 1:n
    for j = 1:n
        if i ~= j
            D(i,j) = sqrt(sum((citys(i,:) - citys(j,:)).^2));
        else
            D(i,j) = 1e-4;      
        end
    end    
end

%% Initialization
m = 50;                              % the number of ant
alpha = 1;                           % alpha factor
beta = 5;                            % beta factor
rho = 0.1;                           % rho factor
Q = 1;                               % constant
Eta = 1./D;                          % heuristic function
Tau = ones(n,n);                     % information matrix
Table = zeros(m,n);                  % record the path
iter = 1;                            % iterations
iter_max = 200;                      % max iterations 
Route_best = zeros(iter_max,n);      % best path at the current generation     
Length_best = zeros(iter_max,1);     % length for the best path
Length_ave = zeros(iter_max,1);      % average length for the path

%% search for the best path
while iter <= iter_max
    % generate the city where the ant start
      start = zeros(m,1);
      for i = 1:m
          temp = randperm(n);
          start(i) = temp(1);
      end
      Table(:,1) = start; 
      % construct the solution space
      citys_index = 1:n;
      % for each ant
      for i = 1:m
          % for each city
         for j = 2:n
             tabu = Table(i,1:(j - 1));           % visited
             allow_index = ~ismember(citys_index,tabu);
             allow = citys_index(allow_index);  % will visit
             P = allow;
             % transfer probability
             for k = 1:length(allow)
                 P(k) = Tau(tabu(end),allow(k))^alpha * Eta(tabu(end),allow(k))^beta;
             end
             P = P/sum(P);
	     % choose the next city to visit 
             Pc = cumsum(P);     
             target_index = find(Pc >= rand); 
             target = allow(target_index(1));
             Table(i,j) = target;
         end
      end
      % compute the length of path
      Length = zeros(m,1);
      for i = 1:m
          Route = Table(i,:);
          for j = 1:(n - 1)
              Length(i) = Length(i) + D(Route(j),Route(j + 1));
          end
          Length(i) = Length(i) + D(Route(n),Route(1));
      end
      % compute the length of shortest path and average length
      if iter == 1
          [min_Length,min_index] = min(Length);
          Length_best(iter) = min_Length;  
          Length_ave(iter) = mean(Length);
          Route_best(iter,:) = Table(min_index,:);
      else
          [min_Length,min_index] = min(Length);
          Length_best(iter) = min(Length_best(iter - 1),min_Length);
          Length_ave(iter) = mean(Length);
          if Length_best(iter) == min_Length
              Route_best(iter,:) = Table(min_index,:);
          else
              Route_best(iter,:) = Route_best((iter-1),:);
          end
      end
      % update the information
      Delta_Tau = zeros(n,n);
      % for each ant
      for i = 1:m
          % for each city
          for j = 1:(n - 1)
              Delta_Tau(Table(i,j),Table(i,j+1)) = Delta_Tau(Table(i,j),Table(i,j+1)) + Q/Length(i);
          end
          Delta_Tau(Table(i,n),Table(i,1)) = Delta_Tau(Table(i,n),Table(i,1)) + Q/Length(i);
      end
      Tau = (1-rho) * Tau + Delta_Tau;
    % iterations
    iter = iter + 1;
    Table = zeros(m,n);
end

%% show results
[Shortest_Length,index] = min(Length_best);
Shortest_Route = Route_best(index,:);
disp(['Shortest Length:' num2str(Shortest_Length)]);
disp(['Shortest Path:' num2str([Shortest_Route Shortest_Route(1)])]);
toc;

