jenkins_instance_type = "t2.micro"
keypair_name = "nouman_pk"
aws_region = "us-east-1"
amis = "ami-01d025118d8e760db"
vpc_id = "vpc-a0eeacda"
public_subnets = ["subnet-648fca5a","subnet-e2e209ec"]
private_subnets = ["subnet-0feb117f9e0981c83","subnet-098cf3f649e95cbef"]
certificate_arn = "arn:aws:acm:us-east-1:020046395185:certificate/3b3e2a2e-6578-4a4e-afbd-fd770a4ccad6"
volume_size = "20"
name = "jenkins"
jenkins_sg_ports = {
    "80" = "0.0.0.0/0"
    "443" = "0.0.0.0/0"
    "22" = "18.212.37.142/32"
    "22" = "172.31.89.80/32"
}
