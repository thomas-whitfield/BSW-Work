# Import libraries necessary for this project
import numpy as np
import pandas as pd
from IPython.display import display # Allows the use of display() for DataFrames

# Import supplementary visualizations code visuals.py
import visuals as vs

# Pretty display for notebooks
### TRW: throws an error message because VS IDE does not debug in ipython
%matplotlib inline

# Load the dataset
in_file = 'titanic_data.csv'
full_data = pd.read_csv(in_file)

# Print the first few entries of the RMS Titanic data
#display(full_data.head())
# Store the 'Survived' feature in a new variable and remove it from the dataset
###TRW: pulls out the survived 0,1 flags for those that survived
outcomes = full_data['Survived']
data = full_data.drop('Survived', axis = 1)

print sum(outcomes)
print sum(data)

# Show the new dataset with 'Survived' removed
#display(data.head())
def accuracy_score(truth, pred):
    """ Returns accuracy score for input truth and predictions. """
    
    # Ensure that the number of predictions matches number of outcomes
    ###TRW: Len is a built-in global function and returns the pasition call of the array.
    if len(truth) == len(pred): 
        
        # Calculate and return the accuracy as a percent
        return "Predictions have an accuracy of {:.2f}%.".format((truth == pred).mean()*100)
    
    else:
        return "Number of predictions does not match number of outcomes!"
    
# Test the 'accuracy_score' function
###TRW: this brings in the pd.read_csv row (array) counts, but the np.ones of 5 means that it is len hardwired at 5. So the array is (1,1,1,1,1)
predictions = pd.Series(np.ones(5, dtype = int))
###TRW: this brings in the survived 1,0 flag from the .cvs data. Array is (0,1,1,1,0). This ensures that the rows from truth and pred match and 6/10 = 60% in this case. Tested at 6 and (0,1,1,1,0,0) and (1,1,1,1,1) = 50%.
#print accuracy_score(outcomes[:6], predictions)
def predictions_0(data):
    """ Model with no features. Always predicts a passenger did not survive. """

    predictions = []
    for _, passenger in data.iterrows():
        
        # Predict the survival of 'passenger'
        predictions.append(0)
    
    # Return our predictions
    ###TRW: this looks like a plug for survived setting the flag to zero by default. I do not know the purpose for yet.
    return pd.Series(predictions)

# Make the predictions
predictions = predictions_0(data)

###TRW: Important to remember that this how many DID NOT survive 61.62% ((891-342)/891) = .6162
print sum(predictions)
print accuracy_score(outcomes, predictions)

#vs.survival_stats(data, outcomes, 'Sex')

def predictions_1(data):
    """ Model with one feature: 
            - Predict a passenger survived if they are female. """
    
    predictions = []
    for _, passenger in data.iterrows():
        
        # Remove the 'pass' statement below 
        # and write your prediction conditions here
        if passenger['Sex'] == 'female':
            predictions.append(1)
        else:
            predictions.append(0)
    
    # Return our predictions
    return pd.Series(predictions)

# Make the predictions
predictions = predictions_1(data)
print sum(predictions)
print accuracy_score(outcomes, predictions)
#vs.survival_stats(data, outcomes, 'Age', ["Sex == 'male'"])

def predictions_2(data):
    """ Model with two features: 
            - Predict a passenger survived if they are female.
            - Predict a passenger survived if they are male and younger than 10. """
    
    predictions = []
    for _, passenger in data.iterrows():
        
        # Remove the 'pass' statement below 
        # and write your prediction conditions here
        if passenger['Sex'] == 'female':
            predictions.append(1)
        else:
            if passenger['Age'] < 10:
                predictions.append(1)
            else:
                 predictions.append(0)    
    # Return our predictions
    return pd.Series(predictions)

# Make the predictions
predictions = predictions_2(data)
print sum(predictions)
print accuracy_score(outcomes, predictions)

def predictions_3(data):
    """ Model with multiple features. Makes a prediction with an accuracy of at least 80%. """
    
    predictions = []
    for _, passenger in data.iterrows():
        
        # Remove the 'pass' statement below 
        # and write your prediction conditions here
        if passenger['Sex'] == 'female':
            if passenger['SibSp'] > 2:
                predictions.append(0)
            else:
                predictions.append(1)
        else:
            if passenger['Age'] < 10:
                predictions.append(1)
            else:
                predictions.append(0)
    
    # Return our predictions
    return pd.Series(predictions)

# Make the predictions
predictions = predictions_3(data)
print sum(predictions)
print accuracy_score(outcomes, predictions)






