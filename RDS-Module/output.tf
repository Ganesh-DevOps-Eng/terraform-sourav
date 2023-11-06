output "my_key_pair" {
  value = aws_key_pair.my_key_pair.key_name
}

output "db_host" {
  value = aws_db_instance.rds.endpoint
}
