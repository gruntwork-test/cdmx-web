output "website_url" {
  description = "The S3 static website endpoint URL"
  value       = "http://${aws_s3_bucket_website_configuration.website.website_endpoint}"
}

output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.website.id
}
