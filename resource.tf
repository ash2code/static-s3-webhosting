resource "aws_s3_bucket" "s3-bucket" {
    bucket = var.bucket_name
    tags = {
        Name = "${local.environment}-bucket"
    }
}

resource "aws_s3_bucket_versioning" "s3-bucket-versioning" {
    bucket = aws_s3_bucket.s3-bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket_public_access_block" "s3-bucket-pub-access" {
    bucket = aws_s3_bucket.s3-bucket.id
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}

resource "aws_s3_object" "s3-copy-index" {
    bucket = aws_s3_bucket.s3-bucket.id
    key = "index.html"
    source = "index.html"
}

resource "aws_s3_object" "s3-copy-error" {
    bucket = aws_s3_bucket.s3-bucket.id
    key = "error.html"
    source = "error.html"
} 

resource "aws_s3_bucket_website_configuration" "s3-bucket-website" {
    bucket = aws_s3_bucket.s3-bucket.id
    index_document {
        suffix = "index.html"
    }
    error_document {
        key = "error.html"
    }
}

resource "aws_s3_bucket_policy" "s3-bucket-policy" {
    bucket = aws_s3_bucket.s3-bucket.id
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Principal = "*"
                Action = [
                    "s3:GetObject",
                    "s3:PutObject",
                ],
                Resource = "arn::aws:s3:::${aws_s3_bucket.s3-bucket.id}/*",
            },
        ],
    })
}

        


