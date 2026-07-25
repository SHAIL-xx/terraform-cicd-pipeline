import boto3
import sys

# Connect to LocalStack S3 and SQS endpoints
s3 = boto3.client('s3', endpoint_url='http://localhost:4566', region_name='us-east-1')
sqs = boto3.client('sqs', endpoint_url='http://localhost:4566', region_name='us-east-1')

def test_resources():
    print("🔎 Running Infrastructure Integration Tests...\n")

    # 1. Test S3 Bucket Existence
    buckets = [b['Name'] for b in s3.list_buckets().get('Buckets', [])]
    assert 'cicd-app-assets-bucket' in buckets, "❌ S3 Bucket 'cicd-app-assets-bucket' was not found!"
    print("✅ S3 Bucket Test Passed: 'cicd-app-assets-bucket' exists.")

    # 2. Test SQS Queue Existence
    queues = sqs.list_queues().get('QueueUrls', [])
    assert any('cicd-job-queue' in q for q in queues), "❌ SQS Queue 'cicd-job-queue' was not found!"
    print("✅ SQS Queue Test Passed: 'cicd-job-queue' exists.")

if __name__ == "__main__":
    try:
        test_resources()
        print("\n🎉 ALL INTEGRATION TESTS PASSED SUCCESSFULLY!")
    except AssertionError as e:
        print(f"\n{str(e)}")
        sys.exit(1)