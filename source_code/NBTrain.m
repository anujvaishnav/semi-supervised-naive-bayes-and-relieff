function [parameters]= NBTrain(AttributeSet, LabelSet )

  classes = unique(LabelSet);
  
  classProbVec = cell(size(classes,1),1);
  priors = cell(size(classes,1),1);
  
  % makes sure you test it with varying weights
%   weight = 0.1;
  
  for class=1:size(classes,1);
    
    priors{class} = sum(LabelSet == classes(class)) ./ size(LabelSet,1);
    
    % prepare class train dataset
    classDataSet = AttributeSet(LabelSet == classes(class),:);
    
    featureProbVec = cell(size(classDataSet,2),1);
    
    for feature=1:size(classDataSet,2)
      
      % Identify attributes of feature
      attributes = unique(AttributeSet(:,feature));
      attributeCount = 0;
      attributeProb = 0;
      
      for attribute=1:size(attributes,1)
        attributeCount(attribute,1) = sum(classDataSet(:,feature) == attributes(attribute));
      end % for each attribute
      
      attributePrior = 1 ./ size(attributes,1);
      
      weight = 0.1 * size(classDataSet,1);
      attributeProb = (attributeCount + weight.*attributePrior) ./ (size(classDataSet,1)+weight);
      
      featureProbVec{feature} = {attributes attributeProb};
      
    end % for each feature
    
    classProbVec{class} = featureProbVec;
    
  end % for classes
  
  parameters = [classProbVec priors];
end