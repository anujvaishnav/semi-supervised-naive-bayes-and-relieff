accuracies = zeros(57,10);
for j = 1: 10;
  
  [rank weights] = relieff(AttributeSet, LabelSet, 10);
  
  
  
  for i = 1: 57
    p = NBTrain(AttributeSet(:, rank <= i), LabelSet);
    [x accuracies(i,j)] = NBTest(p, testAttributeSet(:, rank <= i), validLabel);
  end;
  
end;

plot(1:57, mean(accuracies));