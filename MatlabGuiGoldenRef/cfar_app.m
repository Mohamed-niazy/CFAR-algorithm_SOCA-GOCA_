
function [x data_in z]=cfar_app(mode_str ,dataIn,no_of_gard_win,no_of_reference_win,p_fa)
%% load data to do proccessing on it 
load(['./../DataForGui/' dataIn '.mat']);
data_in= abs(filtered).^2;
%% turn the string data come from gui into numerical variable
 mode =strcmp(mode_str,'GOCA');
no_of_gard_win=str2double(no_of_gard_win);
no_of_reference_win=str2double(no_of_reference_win);
p_fa=str2double(p_fa);
%% calculate alpha 
alpha =no_of_reference_win*(p_fa^(-1/no_of_reference_win)-1);
%% initialize variable 
slide_window=zeros(1,no_of_reference_win+no_of_gard_win+1);
z=[0];
index=[];
%% implementaion cfar_algorithm
for i=1:length(data_in)/2+(no_of_reference_win+no_of_gard_win)/2
slide_window(2:end)=slide_window(1:length(slide_window)-1);
slide_window(1)=data_in(i);
x=mean(slide_window(1:no_of_reference_win/2));
y=mean(slide_window(length(slide_window)-no_of_reference_win/2+1:end));
% choose the wanted algorithm (smallest or greatest )
if mode==1
x=max([x y])*alpha;
else    
x=min([x y])*alpha;
end
if (i>(no_of_reference_win+no_of_gard_win)/2)
z=[z x];
end
if (i>=(no_of_reference_win+no_of_gard_win)/2+1+10)
    q=i-(no_of_reference_win+no_of_gard_win)/2;
    T=data_in(q);
if(T>=data_in(q-1)&&T>=data_in(q+1)&&T>=z(q)&&T>25)
index=[index q];
end 
end
end 
% figure 
plot(1:512,data_in(1:512),'k');
hold on;
% plot(1:512,z(1:512),'r');
legend('Input Data','CFAR Threshold')
x=index;
 
