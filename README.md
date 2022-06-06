# Themis-code
 Source Code for hotstuff with Themis

# How do I Reproduce Your Key Result in the Paper?

## Local Environment
We assume you have the latest [Terraform](https://www.terraform.io/downloads) and [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) installed on your work computer (a work computer is your laptop/home computer). 

[//]: <> (Remove some redundant files.)

we had the folder ``libhotstuff`` for data of original LibHotstuff. The code is the same as [libhotstuff](https://github.com/hot-stuff/libhotstuff). Another folder ``Aequitas-hotstuff/libhotstuff`` is the one integrated Themis.

On your work computer, you have cloned the latest Themis-code repo. Finally, you have already built the repo so binaries hotstuff-keygen and hotstuff-tls-keygen in the two version of libhotstuff are available in their root directory. (See the instructions [here](https://github.com/hot-stuff/libhotstuff) )

Now let's move to reproduce the results. Take a look at [the guide of libhotstuff](https://github.com/hot-stuff/libhotstuff/tree/master/scripts/deploy#local-environment) first to get an idea, our process is nearlly the same.

We use Terraform to launch a bunch of ec2 instance to get the corresponding ``replicas.txt`` and ``client.txt`` in ``scripts/deploy``. You can skip this step if you want to generate it manually.

## How to launch a bunch of ec2 instances

You can skip this step if you want to generate your own ``replicas.txt`` and ``client.txt`` manually.

In the folder Terraform, we have two subfolders. One is for one datacenter (e.g. Ohio), the other is for geo-distributed datacenters.

To use Terraform, you need
- AWS account;
- AWS Identify and Access Management (IAM) credentials and programmatic access. The IAM credentials that you need for EC2 can be found [here](https://aws.amazon.com/cn/blogs/security/granting-permission-to-launch-ec2-instances-with-iam-roles-passrole-permission/);
- setting up AWS credentials locally with aws configure in the AWS Command Line Interface (CLI). You can find further details [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html);
- a VPC configured for EC2. You can find a CloudFormation template to do that [here](https://docs.aws.amazon.com/eks/latest/userguide/creating-a-vpc.html); 

1. Enter the correspondidng folder you want to (``one-region-ohio`` or ``geo-distributed``), open ``resources.tf``, assign ``access_key`` and ``secret_key`` to your ``access key ID`` and ``secret access key`` from your IAM credentials.
2. Change the ``region`` to the datacenter's name.
3. In the block ``resource``, change the ``count`` to the number of servers you need, which equals to ``#replicas + 2``, here ``2`` is for ``client``, and actually we will use one server as ``8`` clients, you can reduce the client number by removing some lines in ``clients.txt``. Also assign ``ami`` to the coresponding VPC configuration for EC2, also ``private_key`` and ``public_key`` to yours that used to log in to the EC2 instance.
4. Run ``./terra_to_txt.sh``.
5. Paste the generated ``replicas.txt`` and ``clients.txt`` to ``Aequitas-hotstuff/libhotstuff/scripts/deploy`` or ``libhotstuff/scripts/deploy``, depending on which one you want to test.

## Before Running the experiments

- You need running following commands in your terminal

        > sudo chmod 600 path/to/your/id_rsa 
        > eval `ssh-agent -s`
        > ssh-add path/to/your/id_rsa

- Now move to ``scripts/deploy`` of coresponding folder.
- Generate ``node.ini`` and ``hotstuff.gen.*.conf`` by running ``./gen_all.sh``.
- Build libhotstuff on all remote machines by ``./run.sh setup``.

 ## For Benchmark Results

- Change the ``block-size`` in ``hotstuff.gen.conf``

- Follow [the third step in the guide of libhotstuff](https://github.com/hot-stuff/libhotstuff/tree/master/scripts/deploy#step-3---run-the-experiment) to reproduce the benchmarks in the folder libhotstuff. 

In the one datacenter setting, when I set the ``block-size`` to ``400``, client number to ``16``, replica number to ``10``. I got the following results:

    [308385, 302775, 304241, 303517, 304156, 301061, 307310, 303565, 302551, 304807, 115632]
    lat = 9.157 ms
    lat = 9.143 ms

Where the first line is the throughput, the second line is the mean end-to-end latency, the third line is the mean end-to-end latency after removing outliers.

[//]: <> (change this to default setting?)


 ## For Themis Results

- Change the ``block-size`` in ``hotstuff.gen.conf``.
- Change the ``#define max_num_all_txn`` to ``block-size + 5`` in ``consensus.h`` and ``hotstuff.cpp``.
- Then follow [the third step in the guide of libhotstuff](https://github.com/hot-stuff/libhotstuff/tree/master/scripts/deploy#step-3---run-the-experiment) to reproduce the results.

[//]: <> (refine the words. check once again?)

In the five geo-distributed datacenters' setting, when I set the block-size to 400, client number to 12, replica number to 100. I got the following results:

    [3183, 2817, 3196, 2804, 2800, 3200, 2800, 2800, 3200, 2800, 3168, 2832, 2800, 3200, 1600]
    lat = 707.553 ms
    lat = 681.231 ms

[//]: <> (change this to default setting?)

## Stop all the launched servers

There is no simple way to stop the server by using Terraform. Therefore we use the UI. In the AWS console, select the servers with the filter "running", then change the instance status to "suspended".
