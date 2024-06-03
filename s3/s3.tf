provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

# Variables
variable "bucket_name" {
  description = "The name of the S3 bucket to create"
  type        = string
}

# Create S3 bucket
resource "aws_s3_bucket" "public_bucket" {
  bucket = var.bucket_name

  # Optional: Configure bucket versioning
  versioning {
    enabled = true
  }

  # Optional: Configure bucket encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# Set the bucket policy to make the entire bucket public
resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.public_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.public_bucket.arn}/*"
      }
    ]
  })
}

# Output the bucket name and URL (optional, for verification)
output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.public_bucket.bucket
}

output "bucket_url" {
  description = "The URL of the S3 bucket"
  value       = "http://${aws_s3_bucket.public_bucket.bucket}.s3.amazonaws.com"
}
