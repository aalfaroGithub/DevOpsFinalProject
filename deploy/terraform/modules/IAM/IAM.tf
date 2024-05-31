resource "aws_iam_role_policy_attachment" "iam-policy" {
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
    role       = aws_iam_role.iam-role.name
}

resource "aws_iam_role" "iam-role" {
    name = var.iam_role
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect = "Allow",
                Principal = {
                    Service = "ec2.amazonaws.com"
                },
                Action = "sts:AssumeRole"
            }
        ]
    })
}

resource "aws_iam_instance_profile" "instance-profile" {
    name = "myuser-instance-profile"
    role = aws_iam_role.iam-role.name
}