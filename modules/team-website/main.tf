locals {
  sanitized_team_name = lower(replace(var.team_name, " ", "-"))
  bucket_name         = "gruntcon-${local.sanitized_team_name}"
  image_filename      = basename(var.image_path)
  image_extension     = lower(trimprefix(regex("\\.[^.]+$", local.image_filename), "."))

  content_type_map = {
    "png"  = "image/png"
    "jpg"  = "image/jpeg"
    "jpeg" = "image/jpeg"
    "gif"  = "image/gif"
    "svg"  = "image/svg+xml"
    "webp" = "image/webp"
  }

  image_content_type = lookup(local.content_type_map, local.image_extension, "application/octet-stream")
}

resource "aws_s3_bucket" "website" {
  bucket        = local.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id

  depends_on = [aws_s3_bucket_public_access_block.website]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.website.arn}/*"
      }
    ]
  })
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.website.id
  key          = "index.html"
  content      = templatefile("${path.module}/templates/index.html.tpl", {
    team_name      = var.team_name
    image_filename = local.image_filename
  })
  content_type = "text/html"
}

resource "aws_s3_object" "image" {
  bucket       = aws_s3_bucket.website.id
  key          = local.image_filename
  source       = var.image_path
  content_type = local.image_content_type
  etag         = filemd5(var.image_path)
}
