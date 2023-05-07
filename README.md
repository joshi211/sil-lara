# sil-lara

Input Files ->

Input_data.csv : CSV file with multilingual simple and complex data shared by SIL (25,342 samples)
Leipzig News Corpora : Pickle file with English phrases labelled with readings grades.


Notebooks ->

LaBSE with CNN-LSTM.ipynb : This notebook reads in the input files, labels the Leipzig data, and concatenates the 2 inputs to create a consolidated, labelled training dataset. It further preprocesses this data, generates the LaBSE embeddings, and trains the downstream deep neural network using the encoded training data. Finally, it also evaluates the performance of the trained model on the validation set for the overall validation set and individual languages using ROC curves and confusion matrices. Finally, the model object is saved to aid in reproduction of results.

lambda_pred.ipynb : This notebook bets the uploaded file from S3 bucket and tokenizes it using the LaBSE tokenizer and then loads the saved model and runs predictions on the input data file. Along with this, it generates a score based on output probabilities and a color band based on pre-defined rules, to aid the classification of the sentence complexity.


Model Object ->

Model_96%_acc.h5 : This is the saved pre-trained model for determining sentence complexity, and should be imported when running predictions on unseen data.



SageMaker Lifecycle Configuration Script ->

sagemaker_lifecycle_configuration.sh : To enable the start of the lambda_pred.ipynb to automate the prediction pipeline.


Lambda Source Code ->

lambda.py : This file starts the SageMaker notebook instance that hosts the model object and the prediction file.





Notes on setting up AWS pipeline and deploying the model on cloud: 
	1) Sagemaker instance: The model training process is memory-heavy. It is better to use ml.r5.8xlarge sagemaker notebook instance with EBS volume attached to ensure permanent storage.
	2) Lambda: Add an s3 trigger to automate the start of the notebook instance.
	3) S3: Create 2 separate s3 buckets. One to upload the csv file containing text that needs to be scored. The final output file with complexity score and colour band will be uploaded to the 2nd bucket.
