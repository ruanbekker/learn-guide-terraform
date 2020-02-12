## What is Terraform

Terraform can be described as Infrastructure as Code, it's like automation of your infrastructure. It provides providers like AWS, GCP, Digital Ocean, Localstack, etc.

Terraform can keep your infrastructure auditable using git and keep your infrastructure at a certain state.

While terraform focuses on creating your infrastructure on a desired state, it also have providers like ansible, saltstack, chef, etc that focus on provisioning the software on the deployed infrastrucutre.

## Installing Terraform

From their [download section](https://www.terraform.io/downloads.html), grab the latest archive:

```
$ mkdir ~/terraform && cd ~/terraform
$ wget https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_darwin_amd64.zip
$ unzip terraform_0.12.20_darwin_amd64.zip
$ export PATH=${PATH}:$PWD
$ terraform version
Terraform v0.12.20
```

## Installing Terraform with Vagrant

Install Vagrant:

- https://blog.ruanbekker.com/blog/2019/05/30/use-vagrant-to-setup-a-local-development-environment-on-linux/
- https://www.vagrantup.com/docs/installation/

The `Vagrantfile`

```
$ cat Vagrantfile
```

The `scripts/install.sh`:

```
$ cat scripts/install.sh
```

Boot the VM:

```
$ vagrant up
```

Access the VM:

```
$ vagrant ssh
```

Test if terraform is installed:

```
$ terraform version
Terraform v0.12.18 
```

