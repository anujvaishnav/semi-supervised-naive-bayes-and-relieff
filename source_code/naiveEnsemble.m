close all;
clear all;
fname = input('Enter a filename to load data for training/testing: ','s');
load(fname);

noOfModel = 10;

ensemble = cell(noOfModel,1);

trainingSet = AttributeSet;
trainingLabels = LabelSet;

weights = ones(noOfModel,size(trainingSet,1)) .* (1/size(trainingSet,1));
accuracies = zeros(noOfModel,1);

for model = 1:noOfModel
  
  %limit = int32(model .* size(AttributeSet,1)/noOfModel);
  
%   trainingSet = AttributeSet(1:limit,:);
%   trainingLabels = LabelSet(1:limit,:);
 
  [trainingSet  indices]= datasample(AttributeSet, size(AttributeSet,1));
  
  trainingLabels = LabelSet(indices);
  
  % Put your NB training function below
  parameters = NBTrain(trainingSet, trainingLabels); % NB training
  
  [predictLabel, accuracy] = NBTest( parameters , trainingSet, trainingLabels); % NB test
  
  accuracies(model) = accuracy;
  ensemble(model) = {parameters};
  
end;

fprintf('Done with training');

%testing

predictedLabel = zeros(size(testAttributeSet, 1),1);

for example = 1:size(testAttributeSet, 1)

  modelLabels = zeros(size(noOfModel,1),1);
  
  %fprintf('classifying testData: %d\n', example);
  
  for model = 1:noOfModel 

    parameterCell = ensemble(model);
    parameters = parameterCell{1,1};
    numerator = zeros(size(parameters,1),1);

    for class = 1:size(parameters,1)

      likelihood = parameters{class,2};

      for feature = 1:size(testAttributeSet,2)

        % get probablity of test attribute for a given feature
        possibleAttributes = parameters{class,1}{feature,1}{1};
        allProbs = parameters{class,1}{feature,1}{2};      
        attributeProb = allProbs(possibleAttributes == testAttributeSet(example,feature));

        likelihood = likelihood .* attributeProb; 

      end % for each feature

      numerator(class) = likelihood;

    end % for each class

    classProbs = numerator ./ sum(numerator);

    modelLabels(model) = find(classProbs == max(classProbs)) -1;

  end; % for each model
  predictedLabel(example,1) = mode(modelLabels);

end % for each example

accuracy = sum(predictedLabel == validLabel) ./ size(testAttributeSet, 1)
