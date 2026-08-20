

############################################
# Public Read Policy
############################################

data "aws_iam_policy_document" "frontend_public_policy" {

  statement {

    sid    = "PublicReadGetObject"
    effect = "Allow"

    principals {

      type        = "*"
      identifiers = ["*"]

    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.frontend.arn}/*"
    ]
  }
}


############################################
# Bucket Policy
############################################

resource "aws_s3_bucket_policy" "frontend" {

  bucket = aws_s3_bucket.frontend.id

  policy = data.aws_iam_policy_document.frontend_public_policy.json

  depends_on = [
    aws_s3_bucket_public_access_block.frontend
  ]
}
