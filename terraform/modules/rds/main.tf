resource "aws_db_subnet_group" "this" {
  name = "wordpress-db"

  subnet_ids = var.subnets

}

resource "aws_security_group" "rds" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "wordpress" {
  identifier        = "wordpress-db"
  engine            = "mysql"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  username = "admin"
  password = "password123"

  db_name = "wordpress"

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name    = aws_db_subnet_group.this.name

  skip_final_snapshot = true
  publicly_accessible  = false
}
