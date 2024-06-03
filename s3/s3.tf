provider "aws" {
  region = "us-west-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name-12345"

  tags = {
    Name        = "MyBucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_bucket.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "my_bucket_encryption" {
  bucket = aws_s3_bucket.my_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "s3:GetObject"
        Effect    = "Allow"
        Resource  = "${aws_s3_bucket.my_bucket.arn}/*"
        Principal = "*"
      },
    ]
  })
}

output "bucket_arn" {
  value = aws_s3_bucket.my_bucket.arn
}
