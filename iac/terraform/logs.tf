resource "aws_s3_bucket" "app" {
  bucket = "${var.project_name}-${var.environment}-app-bucket"

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-app-bucket"
  })
}

resource "aws_s3_bucket_public_access_block" "app" {
  bucket = aws_s3_bucket.app.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "app" {
  bucket = aws_s3_bucket.app.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "AWSLogDeliveryWrite"
        Effect = "Allow"
        Principal = {
          Service = "elasticloadbalancing.amazonaws.com"
        }
        Action = "s3:PutObject"
        Resource = "${aws_s3_bucket.app.arn}/alb-logs/*"
      },
      {
        Sid = "AWSLogDeliveryAclCheck"
        Effect = "Allow"
        Principal = {
          Service = "elasticloadbalancing.amazonaws.com"
        }
        Action = "s3:GetBucketAcl"
        Resource = aws_s3_bucket.app.arn
      }
    ]
  })
}

resource "aws_s3_bucket_lifecycle_configuration" "app" {
  bucket = aws_s3_bucket.app.id

  rule {
    id     = "log-expiration"
    status = "Enabled"

    transition {
      days          = 7
      storage_class = "STANDARD_IA"
    }
    
    transition {
      days          = 30
      storage_class = "GLACIER"
    }

    expiration {
      days = 90
    }

    prefix = "alb-logs/"
  }
}