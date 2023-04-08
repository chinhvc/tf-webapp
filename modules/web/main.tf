# Create a security group for the Nginx web server
resource "aws_security_group" "nginx" {
  name        = "nginx"
  description = "Allow inbound HTTP and HTTPS traffic"
  vpc_id      = var.vpc_id

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
  count         = var.instance_count
  ami           = data.aws_ami.amazon_linux_2.id # Amazon Linux 2 AMI
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  subnet_id     = var.public_subnet_id

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

# Create an RDS Subnet Group for the PostgreSQL database
resource "aws_db_subnet_group" "example" {
  name       = "example"
  subnet_ids = [aws_subnet.private.id]
}

# Create an RDS instance for the PostgreSQL database
# resource "aws_db_instance" "postgres" {
#   identifier           = "postgres"
#   engine               = "postgres"
#   engine_version       = "13.3"
#   instance_class       = "db.t3.micro"
#   allocated_storage    = 20
#   storage_type         = "gp2"
#   username             = var.db_username
#   password             = var.db_password
#   multi_az             = false
#   publicly_accessible  = false
#   vpc_security_group_ids = [aws_security_group.postgres.id]
#   db_subnet_group_name = aws_db_subnet_group.example.name

#   tags = {
#     Name = "PostgreSQL Database"
#   }
# }

resource "aws_db_instance" "private_db" {
  allocated_storage      = var.db_allocated_storage
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  vpc_security_group_ids = [aws_security_group.private_db.id]
  subnet_group_name      = aws_db_subnet_group.private_db_subnet_group.name
  db_subnet_group_name   = aws_db_subnet_group.example.name
  multi_az               = false
  publicly_accessible    = false
}