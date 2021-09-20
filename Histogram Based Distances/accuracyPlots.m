function [acc_val]= accuracyPlots(score_same,score_diff,plotFlag)
% INPUT:
%     score_same: Genuine matching score
%     score_diff: Imposter Matching Score
%     plotFlag: Flag, 1: to plot figures, 0: FALSE
% OUTPUT:
%     acc_val: Accuracy 
%Score Normalized to 0-100
max_score = max(max(score_same), max(score_diff));
min_score = min(min(score_same), min(score_diff));

if (max_score == min_score) %to check if max and min scores are equal
    score_same = 100;
    score_diff = 100;    
else
    score_same = ((score_same - min_score)/(max_score - min_score))*100;
    score_diff = ((score_diff - min_score)/(max_score - min_score))*100;
end;

th_step = 1;

% min=1 and max=100 since score normalized to 0-100)
minthresh = 0;
maxthresh = 100;

nRecords_same = length(score_same);
nRecords_diff = length(score_diff);
  i = 1;
  for thresh=minthresh:th_step:maxthresh
        %count number of values less than thresh 
        frr(i) = sum(score_same > thresh);
        t(i) = thresh;
        i = i+1;
      sprintf('Threshold Same = %f \n',thresh);
  end  
  frr = (frr*100)/nRecords_same;
  i = 1;
  for thresh=minthresh:th_step:maxthresh
          %count number of values greater than thresh 
          far(i)=sum(score_diff <= thresh);
          t(i)=thresh;
          i=i+1;
  end 
  far = (far*100)/nRecords_diff;
  i = 1;
  for thresh=minthresh:th_step:maxthresh
        %count number of values greater than thresh 
        acc(i)=100-((far(i)+frr(i))/2);        
        t(i)=thresh;
        i=i+1;
  end        

%Computation of Accuracy     
[acc_val, th]=max(acc);

if plotFlag
    figure,plot(t,acc,'-o');
    xlabel('threshold');
    ylabel('Accuracy');
    grid on;
end
end
