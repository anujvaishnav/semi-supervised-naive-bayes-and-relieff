function classProbs = NBProb(parameters, testAttributeSet)

  classProbs = zeros(size(testAttributeSet, 1),size(parameters,1));

  for example = 1:size(testAttributeSet, 1)
    
    numerator = zeros(size(parameters,1),1);

    for class = 1:size(parameters,1)
      
      likelihood = parameters{class,2};
%       likelihood = 1 / size(parameters,1);
      
      for feature = 1:size(testAttributeSet,2)
        
        % get probablity of test attribute for a given feature
        possibleAttributes = parameters{class,1}{feature,1}{1};
        allProbs = parameters{class,1}{feature,1}{2};      
        attributeProb = allProbs(possibleAttributes == testAttributeSet(example,feature));
        
        likelihood = likelihood .* attributeProb; 
        
      end % for each feature
      
      numerator(class) = likelihood;
      
    end % for each class
    
    classProbs(example,:) = numerator' ./ sum(numerator);
  end % for each example
end