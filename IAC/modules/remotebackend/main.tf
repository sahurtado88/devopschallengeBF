#IAM terrarform user
resource "aws_iam_user" "terraform_user" {
  name= var.iam_user 
}

#Attach policy to terraform user
resource "aws_iam_user_policy_attachment" "admin_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  user= aws_iam_user.terraform_user.id
}

# S3 bucket for TF state
resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = var.bucket_name
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name = "${var.environment}-${var.bucket_name}"
  }
  
}

#Enable versioning
resource "aws_s3_bucket_versioning" "versioning_enable" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
  
}

# S3 Bucket policy
resource "aws_s3_bucket_policy" "s3_policy" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = "s3:ListBucket",
        Resource= aws_s3_bucket.terraform_state_bucket.arn,
        Principal = {
          AWS = aws_iam_user.terraform_user.arn
        }
      },
      {
        Effect = "Allow",
        Action = ["s3:GetObject","s3:PutObject"],
        Resource= "${aws_s3_bucket.terraform_state_bucket.arn}/*",
        Principal = {
          AWS = aws_iam_user.terraform_user.arn
        }
      }
    ]
  })  
}

#DynamoDB for state locking
resource "aws_dynamodb_table" "state_lock_table" {
  name = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name = "${var.environment}-${var.table_name}"
  }
}
