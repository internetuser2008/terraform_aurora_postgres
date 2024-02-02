output "availability_zones" {
  description = "The availability zones of the instance."
  value       = aws_rds_cluster.cluster.availability_zones
}
output "aurora_postgres_endpoint" {
  description = "The DNS address of the RDS instance."
  value = aws_db_instance.aurora_postgres.endpoint
}
output "reader_endpoint" {
  description = "A read only endpoint for the cluster, automatically load balanced across replicas."
  value       = aws_rds_cluster.cluster.reader_endpoint
}
