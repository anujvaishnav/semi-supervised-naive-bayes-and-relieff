noOfClusters = 5;

data = AttributeSet(:, weights >0);
labels = [LabelSet; validLabel];
for feature = 1:size(data,2)
  attributes = unique(data(:,feature));
  
  for attribute = 1:size(attributes,1)
    index = (data(:,feature) == attributes(attribute));
    
    col = data(:,feature);
    col(index) = attribute;
    data(:,feature) = col;
  end;
end;

for noOfCluster = 1:noOfClusters
  fprintf('making %d clusters\n', noOfCluster);
  
  clusters = kmeans(data, noOfCluster);
  for index = 1: noOfCluster
    fprintf('cluster number = %d\n', index);
    
    cluster = [sum(labels(clusters == index) == 0),...
      sum(labels(clusters == index) == 1),sum(labels(clusters == index) == 2)]
  end
  
end