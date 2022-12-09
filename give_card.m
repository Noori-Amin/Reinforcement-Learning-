function[card]=give_card(i)
card=min(randi(13),10);
if ((card==1)&&(i<3))
    card=11;
end
end
