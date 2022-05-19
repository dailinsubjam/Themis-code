# Themis-code
 Source Code for Themis

# How do I Reproduce Your Key Result in the Paper?

## Local Environment
We assume you have the latest Terraform(https://www.terraform.io/) and Ansible(https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) installed on your work computer (a work computer is your laptop/home computer). 

[//]: <> (change the terraform link to an installation one)

we had the folder "libhotstuff" for data of original Hotstuff. The code is the same as https://github.com/hot-stuff/libhotstuff. Another folder "original" is the one integrated Themis.

[//]: <> (change the folder name...)

On your work computer, you have cloned the latest Themis-code repo. Finally, you have already built the repo so binaries hotstuff-keygen and hotstuff-tls-keygen in the two version of libhotstuff are available in their root directory. (See the instructions here https://github.com/hot-stuff/libhotstuff)

Now let's move to reproduce the results. Take a look at https://github.com/hot-stuff/libhotstuff/tree/master/scripts/deploy#local-environment first to get an idea, our process is nearlly the same.

We use Terraform to launch a bunch of ec2 instance to get the corresponding replicas.txt and client.txt in scripts/deploy. You can skip this step if you want to generate it manually.

## How to launch a bunch of ec2 instances

You can skip this step if you want to generate your own replicas.txt and client.txt manually.

In the folder Terraform, we have two subfolders. One is for one datacenter (e.g. Ohio), the other is for geo-distributed datacenter.

To use Terraform, you need
AWS account;
AWS Identify and Access Management (IAM) credentials and programmatic access. The IAM credentials that you need for EC2 can be found here https://aws.amazon.com/cn/blogs/security/granting-permission-to-launch-ec2-instances-with-iam-roles-passrole-permission/;
setting up AWS credentials locally with aws configure in the AWS Command Line Interface (CLI). You can find further details here https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html;
a VPC configured for EC2. You can find a CloudFormation template to do that here https://docs.aws.amazon.com/eks/latest/userguide/creating-a-vpc.html; 

Enter the correspondidng folder you want to (one-region-ohio or geo-distributed), open resources.tf, assign access_key and secret_key to your access key ID and secret access key from your IAM credentials.

Change the region to the datacenter's name.

In the block "resource", change the count to the number of servers you need, including replicas and clients. In gen_replicas.py, change the number on line16 to the number of clients you use.  Also assign ami to the coresponding VPC configuration for EC2, also private_key and public_key to yours that used to log in to the EC2 instance.

Run ./terra_to_txt.sh
Paste the generated replicas.txt and clients.txt to original/scripts/deploy or libhotstuff/scripts/deploy, depending on which one you want to test.

## Before Running the experiments



You need 
sudo chmod 600 path/to/your/id_rsa 
eval `ssh-agent -s`
ssh-add path/to/your/id_rsa

Now move to scripts/deploy of coresponding folder.
Generate node.ini and hotstuff.gen.*.conf by running ./gen_all.sh.
Build libhotstuff on all remote machines by ./run.sh setup.

 ## For Benchmark Results

Change the block-size in hotstuff.gen.conf

Follow https://github.com/hot-stuff/libhotstuff/tree/master/scripts/deploy#step-3---run-the-experiment to reproduce the benchmarks in the folder libhotstuff. 

When I set the block-size to 400, client number to 2 (and in fact we have 2 * 8 = 16 clients running), replica number to 5. I got the following results:
[...311455, 313133, 314816, 313665...]
lat = 8.894ms # after removing outliers

 [//]: <> (you need to really re-run it)


 ## For Themis Results

Change the block size in hotstuff.gen.conf
Change the #define max_num_all_txn in consensus.h and hotstuff.cpp
[//]: <> (refine the words)
Then follow https://github.com/hot-stuff/libhotstuff/tree/master/scripts/deploy#step-3---run-the-experiment to reproduce the results.

In the one datacenter setting, when I set the block-size to 400, client number to 2 (and in fact we have 2 * 8 = 16 clients running), replica number to 5. I got the following results:

[//]: <> (you need to really re-run it)

## Stop all the launched server

In the AWS console, select the filter "running" for all the servers, then selecte the filter "stop all".
 [//]: <> (to be confirmed)