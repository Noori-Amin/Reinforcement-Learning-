function[states]=build_state_list()
player=12:21;
delear=2:11;
n=1;
for i=1:length(player)
    for j=1:length(delear)
        states(n,:)=[player(i) delear(j)];
        n=n+1;
    end
end