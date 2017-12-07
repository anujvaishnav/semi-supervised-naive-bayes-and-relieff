close all;
clear all;
fname = input('Enter a filename to load data for training/testing: ','s');
load(fname);

limit = 10*int32(size(AttributeSet,1)/10);

labeledData = AttributeSet(1: limit,:);
labels = LabelSet(1: limit,:);
unlabeledData = [AttributeSet(limit:end,:)];

data = [labeledData; unlabeledData];

testingSet = testAttributeSet;
testingLabels = validLabel;

probs = zeros(size(labeledData,1),size(unique(labels),1));

allLabels = unique(labels);

for label = 1:size(allLabels,1)
  probs(1:size(labels,1),label) = (labels == allLabels(label));
end;

[parameters priors] = SNBTrain(data, probs, size(labels,1));

noOfIteration = 5;
for iteration = 1: noOfIteration

  %%%%%%% Predict classes %%%%%%%%
  probs = SNBTest(parameters, priors, data);
  
  %%%%%%%% Retrain model %%%%%%%%%
 
  [parameters priors] = SNBTrain(data, probs, size(probs,1));
  
  MainsizeOfProbs = size(priors,2)
  
  iteration
  priors
end; % for iteration


%%%%%%%%%%%%%%%% Testing %%%%%%%%%%%%%%%%

probs = SNBTest(parameters, priors, testingSet);