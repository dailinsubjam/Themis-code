#ohio
provider "aws" {
  region = "us-east-2"
  access_key = #to_be_filled
  secret_key = #to_be_filled
}

#seoul
provider "aws" {
	alias = "apnortheast2"
	region = "ap-northeast-2"
  	access_key = #to_be_filled
  	secret_key = #to_be_filled
}

#tokyo
provider "aws" {
	alias = "apnortheast1"
	region = "ap-northeast-1"
  	access_key = #to_be_filled
  	secret_key = #to_be_filled
}

#frankfurt
provider "aws" {
	alias = "eucentral1"
	region = "eu-central-1"
  	access_key = #to_be_filled
  	secret_key = #to_be_filled
}

#california
provider "aws" {
	alias = "uswest1"
	region = "us-west-1"
  	access_key = #to_be_filled
  	secret_key = #to_be_filled
}

#ohio
resource "aws_instance" "server_useast2" {
	count = 0 //20 + 2

	ami = "ami-0fc20dd1da406780b"
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

output "instance_ip_useast2" {
	description = "The public ip for ssh access"
	value = aws_instance.server_useast2.*.public_ip
}

#seoul
resource "aws_instance" "server_apnortheast2" {
	provider = aws.apnortheast2

	count = 0

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


output "instance_ip_apnortheast2" {
	description = "The public ip for ssh access"
	value = aws_instance.server_apnortheast2.*.public_ip
}

#tokyo
resource "aws_instance" "server_apnortheast1" {
	provider = aws.apnortheast1

	count = 0

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


output "instance_ip_apnortheast1" {
	description = "The public ip for ssh access"
	value = aws_instance.server_apnortheast1.*.public_ip
}


#frankfurt
resource "aws_instance" "server_eucentral1" {
	provider = aws.eucentral1

	count = 0

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


output "instance_ip_eucentral1" {
	description = "The public ip for ssh access"
	value = aws_instance.server_eucentral1.*.public_ip
}


#california
resource "aws_instance" "server_uswest1" {
	provider = aws.uswest1

	count = 0

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


output "instance_ip_uswest1" {
	description = "The public ip for ssh access"
	value = aws_instance.server_uswest1.*.public_ip
}

