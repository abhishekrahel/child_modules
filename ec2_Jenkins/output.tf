output "instance_name" {
    value = aws_instance.jenkins.instance_type
}


output "ami" {
    value = aws_instance.jenkins.ami
}

