output "public_url" {
  value = "http://${module.lb.public_ip}"
}

output "public_ip" {
  value = module.lb.public_ip
}
