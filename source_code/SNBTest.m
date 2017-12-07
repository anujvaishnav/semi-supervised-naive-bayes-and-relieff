function [probs] = SNBTest(parameters, priors, data)
  
  sizeOfPrior = size(priors,2)

  probs = zeros(size(data,1), size(priors,2));
  for example = 1:size(data,1)
    
    numerator = zeros(size(priors,2),1);
 
    for class = 1:size(priors,2)
    
      likelihood = priors(class);
      
      for feature = 1: size(data,2)
      
         % get probablity of test attribute for a given feature        
         possibleAttributes = zeros(size(parameters{feature,1},1),1);
         for i = 1: size(possibleAttributes)
           possibleAttributes(i,:) = parameters{feature,1}{i,1};
         end;
         
         index = (data(example, feature) == possibleAttributes);
%          allCount = parameters{feature,1}{index,2};
         allProbs = parameters{feature,1}{index,2};
%          attributeCount = allCounts(class + 1);
%          totalCount = allCounts(1,1);
         attributeProb  = allProbs(class);
%          likelihood =  likelihood * ((attributeCount + likelihood) / (totalCount + m));
           likelihood =  likelihood * attributeProb;
      end; % for feature

      numerator(class,:) = likelihood;
      
    end; % for class
    
    probs(example,:) = numerator ./ sum(numerator);
    
  end; % for examples
  
  %size(probs,2);
  
end % function