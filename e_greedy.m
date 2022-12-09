function [num_action]=e_greedy(Q_table,num_state,epsilon)
rand_num=random('uniform',0,1);
napar=1;
[~,index]=max(Q_table(num_state,:));
if rand_num<(1-epsilon)
    num_action=index;
else
    while(napar)
        num_action=randi(size(Q_table,2));
        if num_action~=index
            napar=0;
        end
    end
end
