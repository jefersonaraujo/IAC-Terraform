module "project-iac" {
  source = "../../infra"
}


data "template_file" "container_definitions" {
  template = file("./container_definitions.json")
}

module "ecs_mentoria" {
  source           = "../../modules/ecs"
  create_cluster   = true
  app_count        = 1
  fargate_cpu      = 256
  fargate_memory   = 512
  subnet_ids      = ["subnet-11fc983a", "subnet-41d5391c", "subnet-35415c4c", "subnet-e7a996ac"]
  vpc_id          = "vpc-b2b131ca"
  protocol         = "HTTP"
  family_name      = "mentoria"
  service_name     = "mentoria"
  cluster_name     = "mentoria"
  container1_name  = "api"
  container1_port  = 8000
  container_definitions = data.template_file.container_definitions.rendered

  tags = {
    Env          = "production"
    Team         = "tematico-terraform"
    System       = "api"
    CreationWith = "terraform"
  }
}

output "load_balancer_dns_name" {
  value = "http://${module.ecs_mentoria.loadbalance_dns_name}"
}

output "security_group_id" {
  value = module.ecs_mentoria.security_group_id
}
