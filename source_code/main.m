
%close all;
clear all;
fname = input('Enter a filename to load data for training/testing: ','s');
load(fname);

noOfExperiments = 10;

accuracies = zeros(noOfExperiments,1);

for experiment = 1:noOfExperiments
  
  limit = int32(experiment .* size(AttributeSet,1)/noOfExperiments);
  
  trainingSet = AttributeSet(1:limit,:);
  trainingLabels = LabelSet(1:limit,:);
  testingSet = testAttributeSet;
  testingLabels = validLabel;
  
  % Put your NB training function below
  parameters = NBTrain(trainingSet, trainingLabels); % NB training
  % Put your NB test function below
  [predictLabel, accuracy] = NBTest( parameters , testingSet, testingLabels); % NB test

  %fprintf('********************************************** \n');
  %fprintf('Overall Accuracy on Dataset %s: %f \n', fname, accuracy);
  %fprintf('ConfusionMatrix of parts: %d', parts);
  confusionMatrix = confusionmat(predictLabel, testingLabels);
  %fprintf('********************************************** \n');

  accuracies(experiment) = accuracy;
end;

confusionMatrix

plot(1:noOfExperiments,accuracies, 'r');
hold on;
xlabel('No of data partition used for training');
ylabel('Accuracy');