# Create an RDS Subnet Group for the PostgreSQL database
resource "aws_db_subnet_group" "example" {
  name       = "example"
  subnet_ids = [aws_subnet.private.id]
}

# Create an RDS instance for the PostgreSQL database
resource "aws_db_instance" "postgres" {
  identifier             = "postgres"
  engine                 = "postgres"
  engine_version         = "13.3"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  username               = var.db_username
  password               = var.db_password
  multi_az               = false
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.postgres.id]
  db_subnet_group_name   = aws_db_subnet_group.example.name

  tags = {
    Name = "PostgreSQL Database"
  }
}