{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowCloudFrontServicePrincipal",
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "${s3_bucket_arn}/*",
      "Principal": {
        "Service": "cloudfront.amazonaws.com"
      },
      "Condition": {
        "StringEquals": {
          "AWS:SourceArn": "${cloudfront_arn}"
        }
      }
    }
  ]
}
