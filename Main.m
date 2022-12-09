clear all
close all
clc
states=build_state_list();
actions=build_action_list();
Q=zeros(size(states,1),size(actions,2));
epsilon=0.5;
n=1;
alpha=0.1;
for game=1:10000
    player_sum=0;
    delear_sum=0;
    
    for i=1:2
        player(i)=give_card(i);
        player_sum=player_sum+player(i);
        delear(i)=give_card(i);
        delear_sum=delear_sum+delear(i);
        delear_showing_card=delear(1);
    end
    if player_sum==22
        player_sum=21;
    end
    
    
    while(player_sum<12)
        i=i+1;
        player(i)=give_card(i);
        player_sum=player_sum+player(i);
    end
    while(1)
        state=[player_sum  delear_showing_card];
        num_state=find(ismember(states,state,'rows'));
        %     num_state=find(states(:,1)==state(1)& states(:,2)==state(2))
        num_action=e_greedy(Q,num_state,epsilon);
        chain_state_action(n,:)=[num_state num_action];
        n=n+1;
        if num_action==1   % (hit)it means that player recieve another card
            i=i+1;
            player(i)=give_card(i);
            player_sum=player_sum+player(i);
            if player_sum>=22
                player_sum=22;
                reward=-1;
                break
            end
        elseif num_action==2    % (stick)it means that player stop receiving card
            i=2;
            while(delear_sum<17)
                i=i+1;
                delear(i)=give_card(i);
                delear_sum=delear_sum+delear(i);
            end
            if (((player_sum>delear_sum)&&(player_sum<22))||delear_sum>22)
                reward=1;
            elseif player_sum==delear_sum
                reward=0;
            else
                reward=-1;
            end
            break
        end
    end
    for n=1:size(chain_state_action,1)
        Q(chain_state_action(n,1),chain_state_action(n,2))= ...
            Q(chain_state_action(n,1),chain_state_action(n,2))+ alpha*[reward- ...
            Q(chain_state_action(n,1),chain_state_action(n,2))];
    end
    epsilon=epsilon*0.999;
end
for j=1:size(Q,1)
    policy{j,1}=states(j,:);
    if Q(j,1)>Q(j,2)
        policy{j,2}='hit';
    else
        policy{j,2}='stick';
    end
end

