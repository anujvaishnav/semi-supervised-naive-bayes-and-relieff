accuracy = zeros(57,10);

for exp = 1: 10
  for i = 1: 57
  
  forest = TreeBagger(10, AttributeSet, LabelSet, 'NVarToSample', i);
  predictedLabels = cellfun(@str2num, predict(forest, testAttributeSet));
  accuracy(i,exp) = sum(predictedLabels == validLabel) / size(validLabel,1);

  end;
end;
plot(1:57, mean(accuracy,2));