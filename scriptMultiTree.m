clear all
rng_list = [504,505,506];
Nlist = [100, 150, 200, 250, 300, 350, 400];
for i = 1:numel(Nlist)
    N = Nlist(i);
    fprintf('%%%%%%%%%%%%%%%% N=%i %%%%%%%%%%%%%%%%\n', N)
    for r = 1:numel(rng_list)
        fprintf('%%%%%%%%%%%%%%%% rng=%i %%%%%%%%%%%%%%%%\n', rng_list(r))
        rng(rng_list(r))
        try
            showGraph;
            name = sprintf('GraphWE_N%i_rng%i.mat', N, rng_list(r));
            save(name, 'G')
        catch 
            continue
        end
    end
end