resource "aws_instance" jenkins {
    ami = var.ami
    instance_type = var.instance_type
    tags = var.tags
    region = var.region
}

