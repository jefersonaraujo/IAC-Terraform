data "template_file" "container_definitions" {
  template = file("./container_definitions.json")
}


module "ecs" {
  source                = "../../../modules/ecs_ec2"
  create_cluster        = true
  region                = "us-west-2"
  app_count             = 1
  fargate_cpu           = 256
  fargate_memory        = 512
  subnet_ids            = ["subnet-11fc983a", "subnet-41d5391c", "subnet-35415c4c", "subnet-e7a996ac"]
  vpc_id                = "vpc-b2b131ca"
  protocol              = "HTTP"
  family_name           = "frontend"
  service_name          = "frontend"
  cluster_name          = "terraform-iac"
  container1_name       = "frontend"
  container1_port       = 80
  container_definitions = data.template_file.container_definitions.rendered

  tags = {
    Env          = "production"
    Team         = "tematico-terraform"
    System       = "app"
    CreationWith = "terraform"
  }
}

output "load_balancer_dns_name" {
  value = "http://${module.ecs.loadbalance_dns_name}"
}

output "security_group_id" {
  value = module.ecs.security_group_id
}
