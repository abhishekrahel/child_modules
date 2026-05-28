resource "aws_instance" ansible {
    ami = var.ami
    instance_type = var.instance_type
    tags = var.tags
    region = var.region
    key_name      = aws_key_pair.deployer.key_name
    
}

resource "aws_key_pair" "deployer"{
    key_name   = "deployer_key"
    public_key = file ("C:/Users/admin/.ssh/id_rsa.pub")
}

