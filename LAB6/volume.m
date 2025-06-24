function vol=volume(a,b,P,T)

delv=1000;
v_old=(8.314*T)./P;


while delv> 1e-6
    v_new=((8.314*T)./(P+(a./(v_old.*v_old))))+b;
    delv=abs(v_new-v_old);
    v_old=v_new;
end
vol=v_new;
end