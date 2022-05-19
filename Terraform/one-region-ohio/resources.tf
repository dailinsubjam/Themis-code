provider "aws" {
  region = "us-east-2"
  access_key = "AKIAXKG2MU6RLD6J5PRP"
  secret_key = "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"
}

resource "aws_instance" "server" {
	count = 5+2

	ami = "ami-0fc20dd1da406780b"
	instance_type = "c5.4xlarge"
	
//	instance_state = "terminated"

	tags= {
		Name	= "Sishan-Terraform-${count.index}"
	}
	vpc_security_group_ids = ["sg-0f10e07f1b11c2832"]
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
	public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC46eU2WzzbyDANgj75ZZfE4166y1XCg2tDr7mqKaIMy/Z0ZjOnkcEw+bL/3G+vGDKqBnMoJxWDoQP/hnx2gfjbWo1yHVeiBk6POmB9tQfWuKfpjuIFsuLDAB3BcXCg4aG26gTXcnD5yKSexsASsB351CyeBqn38qPXEo6LJKa4zKHJRLm/R9xtgnUbjIMTX5Bp+PPLhRmxns4CGGE3wJjFVR4ZoCvKJRPHiX+eEmgUX6R7XIZK+fLUHuYSAIhhQHDeIUhqTSf9e6dqo1LTmmppbodp2R8zAdFSmGCNFMDWqm6RJoBI+R35+rPElYHslycmKuw/nt7mwdY77wbFeL81 sishanlong@dyn-129-236-226-69.dyn.columbia.edu"
}
