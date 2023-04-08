# Create a security group for the Nginx web server
resource "aws_security_group" "nginx" {
  name        = "nginx"
  description = "Allow inbound HTTP and HTTPS traffic"
  vpc_id      = aws_vpc.example.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance for the Nginx web server
resource "aws_instance" "nginx" {
  ami           = data.aws_ami.amazon_linux_2.id # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = "key_pair_credz"

  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.nginx.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install nginx
              sudo systemctl enable nginx
              sudo systemctl start nginx
              EOF

  tags = {
    Name = "Nginx Web Server"
  }
}

# Create a security group for the PostgreSQL database
resource "aws_security_group" "postgres" {
  name        = "postgres"
  description = "Allow inbound PostgreSQL traffic"
  vpc_id      = aws_vpc.example.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.nginx.id] # Allow only the Nginx web server to access the database
  }
}