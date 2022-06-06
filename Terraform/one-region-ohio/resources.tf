provider "aws" {
  region = "us-east-2"
  access_key = #to_be_filled
  secret_key = #to_be_filled
}

resource "aws_instance" "server" {
	count = 5+2

	ami = #to_be_filled
	instance_type = "c5.4xlarge"
	
//	instance_state = "terminated"

	tags= {
		Name	= "Sishan-Terraform-${count.index}"
	}
	vpc_security_group_ids = #to_be_filled
	associate_public_ip_address = true
	key_name = "id_rsa"
	connection  {
		type = "ssh"
		host = self.public_ip
		user = "ubuntu"
		private_key = file("~/.ssh/id_rsa")
	}
	
}

output "instance_ip" {
	description = "The public ip for ssh access"
	value = aws_instance.server.*.public_ip
}

resource "aws_key_pair" "id_rsa" {
	key_name = "id_rsa"
	public_key = #to_be_filled
}
