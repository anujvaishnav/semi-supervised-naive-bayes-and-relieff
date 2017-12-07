function [parameters priors] = SNBTrain(AttributeSet, probs, sizeOfProbs)

  priors = sum(probs,1) / size(probs,1);
%   weight = 0.1;
  %table = cell(size(probs,1),1);
  
  parameters = cell(size(AttributeSet,2),1);
  
  for feature = 1: size(AttributeSet,2)
  
    attributes = unique(AttributeSet(:,feature));
    parameters{feature,1} = cell(size(attributes,1),2);
    
    for attribute = 1: size(attributes,1)
    
      index = AttributeSet(:,feature) == attributes(attribute);
      parameters{feature,1}{attribute,1} = attributes(attribute);
      %parameters{feature,1}{attribute, 2} = [sum(index,1) sum(probs(index,:),1)];
      
      attributePrior = 1 ./ size(attributes,1);
      weight = 200;
      parameters{feature,1}{attribute, 2} = (sum(probs(index,:),1) + attributePrior * weight)/(sizeOfProbs + weight);
    
    end;
    
  end;
end