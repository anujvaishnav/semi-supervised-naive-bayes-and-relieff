close all;
clear all;
fname = input('Enter a filename to load data for training/testing: ','s');
load(fname);

AttributeSet = AttributeSet(:, 1:48);
testAttributeSet = testAttributeSet(:,1:48);

%for i = 1:10

  limit = 100*int32(size(AttributeSet,1)/100);

  labeledData = AttributeSet(1: limit,:);
  labels = LabelSet(1:limit, :);
  unlabeldLimit = int32(1*size(testAttributeSet,1)/3);
  unlabeledData = [AttributeSet(limit:end,:) ; testAttributeSet(1:unlabeldLimit,:)];

  validationSet = testAttributeSet(unlabeldLimit : int32(2*size(testAttributeSet,1)/3),:);
  validationLabel = validLabel(unlabeldLimit : int32(2*size(testAttributeSet,1)/3),:);
  
  testingLimit = int32(2*size(testAttributeSet,1)/3);
  testingSet = testAttributeSet(testingLimit:end,:);
  testingLabels = validLabel(testingLimit:end,:);

  data = [labeledData; unlabeledData];

  parameters = NBTrain(labeledData, labels); % NB training

  [predictLabel, accuracy] = NBTest(parameters , testingSet, testingLabels);

  fprintf('accuracy with supervised naive bayes: ');
  accuracy = (accuracy*100)

  prevLabels = ones(size(data,1),1);
  predictedLabel = zeros(size(data,1),1);

  j = 1;
  bag = {};
  bag{j} = parameters;
  accuracies = 0;

  while(sum(prevLabels ~= predictedLabel) ~= 0)
    
    prevLabels = predictedLabel;
    predictedLabel = NBPredict(parameters, data);
    
    [dump x] = NBTest(parameters, validationSet, validationLabel);
    accuracies(j) = x;
    
    parameters = NBTrain(data, predictedLabel);
    bag{j+1} = parameters;
    j = j +1
  end;

  % testingSet = testAttributeSet(int32(size(testAttributeSet,1)/2):end,:);
  % testingLabels = validLabel(int32(size(testAttributeSet,1)/2):end,:);

  accuracies
  
  [predictLabel, accuracy] = NBTest(parameters , testingSet, testingLabels);

  accuracy = accuracy*100
%end;