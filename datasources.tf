data "aws_ami" "server_ami" {
    most_recent = true
    #owners = ["113296392243"]

    filter {
      name = "name"
      values = ["*amzn2-ami-kernel-5.10-hvm-2.0.20231101.0-x86_64-gp2*"]
    }
}