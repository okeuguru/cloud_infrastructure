import os
import json
import boto3
import logging
import traceback

log_level = os.environ.get('LOG_LEVEL', 'INFO')

logger = logging.getLogger()
logger.setLevel(log_level)


def lambda_handler(event, context):

    try:
        s3 = boto3.client('s3')
        for record in event['Records']:

            bucket_name = record['s3']['bucket']['name']
            object_key = record['s3']['object']['key']
            response = s3.get_object(Bucket=bucket_name, Key=object_key)
            content = response['Body'].read()
            logger.info(f"File content: {content}")

        return {
            'statusCode': 200,
            'body': json.dumps('Success')
        }
    except Exception as e:
        logger.error(f"Error processing S3 event: {str(e)}")
        logger.error(traceback.format_exc())
        return {
            'statusCode': 500,
            'body': json.dumps('Error')
        }
