#iam stuff
resource "aws_iam_instance_profile" "S3UploadRoleProfile" {
  name = "S3UploadProfile"
  role = "${aws_iam_role.bhavIAMRole.id}"
}
resource "aws_iam_role_policy" "bhavS3Upload" {
  name = "bhavS3Upload"  
  role = "${aws_iam_role.bhavIAMRole.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject",
        "s3:ListBucket",
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.temp_adop_credentials.id}/*"
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "AssumeRolePolicyDocument" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "bhavIAMRole" {
  name               = "bhavIAMRole"
  path               = "/system/"
  assume_role_policy = "${data.aws_iam_policy_document.AssumeRolePolicyDocument.json}"
}