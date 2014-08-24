Codebook for the variables generated
======================

**This codebook extends the feature descriptions located on the file features\_info.txt contained on the dataset's package.**

## Output Variables

### TidyDataSet

Table with dimensions 10299x81, where each row is an observation and each column a feature.  
This tidyDataSet agregates the whole data of the 6 files into a single table to make analysis easier.

* Column 1 (numeric): SubjectID
	The columns 1 subjectID extracted from the subject\_test.txt and subject\_train.txt, contains the number of the subject ID for that observation. Goes from 1 to 30.
* Column 2 (factor): Activity
	The activity were turned into a factor that relates the number 1 to 6 into the following activity labels: WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING and LAYING
* Column 3:81 (numeric): features described on the features.txt from the dataset packaged. There is no especial modification


### AnalysysSet
Table with dimensions 180:81, where each row is an observation and each column a feature.
This table contains the means for each feature of the tidyDataSet splitted by activity and test subject. The 180 rows were defined by crossing the number of subjects and activies (30 and 6).

* Column 1 (numeric): SubjectID
	The columns 1 subjectID extracted from the subject\_test.txt and subject\_train.txt, contains the number of the subject ID for that observation. Goes from 1 to 30.
* Column 2 (factor): Activity
	The activity were turned into a factor that relates the number 1 to 6 into the following activity labels: WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING and LAYING
* Column 3:81 (numeric): Contains the column mean for the observations of determined current subject and activity.
