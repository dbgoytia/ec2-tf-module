# SSM instance role

resource "aws_iam_role" "ssm_role" {
  name = format(
    "%s-ssm-role",
    var.name,
  )

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
}

# Core SSM functionallity
resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# EC2 Instance profile for SSM
resource "aws_iam_instance_profile" "this" {
  name = format(
    "%s-instance-profile",
    var.name,
  )
  role = aws_iam_role.ssm_role.name
}

resource "aws_instance" "this" {

  # general configuration
  ami           = var.ami
  instance_type = var.instance_type

  # networking
  availability_zone           = var.az
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address

  # ssm configuration
  iam_instance_profile = aws_iam_instance_profile.this

  user_data = var.user_data

  # root volume configuration
  root_block_device {
    volume_size = 50
    encrypted   = true
  }

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )

}