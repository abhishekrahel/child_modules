output "instance_name" {
    value = aws_instance.ansible.instance_type
}


output "ami" {
    value = aws_instance.ansible.ami
}

