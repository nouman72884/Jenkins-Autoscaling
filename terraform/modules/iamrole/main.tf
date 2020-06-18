resource "aws_iam_role" "jenkins_role" {
  name = "jenkins_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      Name = "jenkins_role"
  }
}
resource "aws_iam_role_policy" "jenkins_role_policy" {
  name = "jenkins_role_policy"
  role = aws_iam_role. jenkins_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF
}

# resource "aws_iam_role_policy_attachment" "test-attach" {
#   role       = aws_iam_role.ec2_role.name
#   policy_arn = aws_iam_role_policy.policy.arn
# }
resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance_profile"
  role = aws_iam_role.jenkins_role.name
}

