provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

# Variables
variable "bucket_name" {
  description = "The name of the existing S3 bucket where keys will be stored"
  type        = string
}

variable "iam_user_name" {
  description = "The name of the IAM user to create"
  type        = string
}

# Create IAM user
resource "aws_iam_user" "user" {
  name = var.iam_user_name
}

# Attach AdministratorAccess policy to the user
resource "aws_iam_user_policy_attachment" "user_admin_policy" {
  user       = aws_iam_user.user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Create IAM access keys for the user
resource "aws_iam_access_key" "user_keys" {
  user = aws_iam_user.user.name
}

# Store access keys in S3 bucket
resource "aws_s3_bucket_object" "access_key" {
  bucket = var.bucket_name
  key    = "${aws_iam_user.user.name}_access_key.txt"
  content = <<EOF
  [default]
  aws_access_key_id = ${aws_iam_access_key.user_keys.id}
  aws_secret_access_key = ${aws_iam_access_key.user_keys.secret}
EOF
}

# Output the access key and secret access key (optional, for verification)
output "access_key_id" {
  description = "The access key ID for the IAM user"
  value       = aws_iam_access_key.user_keys.id
}

output "secret_access_key" {
  description = "The secret access key for the IAM user"
  value       = aws_iam_access_key.user_keys.secret
  sensitive   = true
}