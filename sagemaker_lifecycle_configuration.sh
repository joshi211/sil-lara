#!/bin/bash
set -e
ENVIRONMENT=pytorch_p39
source /home/ec2-user/anaconda3/bin/activate "$ENVIRONMENT"
nohup jupyter nbconvert /home/ec2-user/SageMaker/lambda_pred.ipynb --ExecutePreprocessor.kernel_name=python --execute --to notebook --output /home/ec2-user/SageMaker/lambda_pred-output.ipynb &
source /home/ec2-user/anaconda3/bin/deactivate

(crontab -l 2>/dev/null; echo "*/1 * * * * /usr/bin/python /home/ec2-user/SageMaker/autostop.py --time $IDLE_TIME --ignore-connections") | crontab -e
