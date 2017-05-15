global fnum
figure(6);
load DE.mat;
Path{1} = Best;
plot(Best(:,1)',Best(:,2)','Color','r');  hold on;
Value(1) = benchmark(Best(end,:),1,fnum);
load GA.mat;
Path{2} = Best;
plot(Best(:,1)',Best(:,2)','Color','b');  hold on;
Value(2) = benchmark(Best(end,:),1,fnum);
load PSO.mat;
Path{3} = Best;
plot(Best(:,1)',Best(:,2)','Color','g');  hold on;
Value(3) = benchmark(Best(end,:),1,fnum);
load HS.mat;
Path{4} = Best;
plot(Best(:,1)',Best(:,2)','Color','k');  hold on;
legend('DE','GA','PSO','HS');
Value(4) = benchmark(Best(end,:),1,fnum);
d=zeros(4,4);f=1e10*ones(4,4);s=zeros(4,4);
% for i=1:4
%     for j=i:4
%         if i~=j
%             Temp = Path{i}-Path{j};
%             for k=1:999
%                 d(i,j) = d(i,j) + norm(Temp(k,:));
%             end
%             f(i,j) = max(Value(j),Value(i));
%             s(i,j) = d(i,j)/f(i,j);
%         end
%     end
% end
