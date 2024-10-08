ROLE_ARN=$1
OUTPUT_PROFILE=$2

echo "Assuming role $ROLE_ARN"
sts=$(aws sts assume-role \
    --role-arn "$ROLE_ARN" \
    --role-session-name "$OUTPUT_PROFILE" \
    --query 'Credentials.[AccessKeyId,SecretAccessKey,SessionToken]' \
    --output text)
echo "Converting sts to array"
sts=($sts)
aws configure set aws_access_key_id ${sts[0]} --profile $OUTPUT_PROFILE
aws configure set aws_secret_access_key ${sts[1]} --profile $OUTPUT_PROFILE
aws configure set aws_session_token ${sts[2]} --profile $OUTPUT_PROFILE
echo "AWS Credentials are stored in the profile named $OUTPUT_PROFILE"
echo "You can now use the new temporary profile to run aws cli commands e.g. 'aws s3 ls --profile $OUTPUT_PROFILE --region eu-central-1'"