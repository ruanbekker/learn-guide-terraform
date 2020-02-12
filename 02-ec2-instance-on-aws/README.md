## Lab: Setup a Basic EC2 Instance

If you have not set your administrator AWS account's access keys, go ahead and do that. I will be setting up my administrator account as the profile `admin`:

### Setup Admin Account

```
$ aws configure --profile admin
AWS Access Key ID [None]: xxxx
AWS Secret Access Key [None]: yyyy
Default region name [None]: eu-west-1
Default output format [None]: json
```

### Create IAM User

We need to create a IAM account for Terraform that will be responsible for creating the EC2 instance.

I will create a IAM user named `terraform`, with a IAM Policy named `TerraformEC2Policy`, which will have full permissions on EC2:

```
$ export AWS_PROFILE="admin"
$ export AWS_USER="terraform"
$ export AWS_IAM_POLICY_NAME="TerraformEC2Policy"
```

After setting the environment variables, create the IAM User:

```
$ aws --profile "${AWS_PROFILE}" iam create-user --path "/" --user-name "${AWS_USER}" 
{
    "User": {
        "UserName": "terraform",
        "Path": "/",
        "Arn": "arn:aws:iam::xxxxxxxxxxxx:user/terraform",
        "UserId": "AIDATPRT2XXXXXXXXXXXX",
        "CreateDate": "2020-02-12T16:09:20Z"
    }
}
```

Attach the IAM Policy to the User:

```
$ aws --profile "${AWS_PROFILE}" iam put-user-policy \
--user-name "${AWS_USER}" \
--policy-name "${AWS_IAM_POLICY_NAME}" \
--policy-document "{\"Statement\":[{\"Effect\":\"Allow\",\"Action\":\"ec2:*\",\"Resource\":\"*\"}]}"
```

Create AWS Access Keys for your User:

```
$ aws --profile "${AWS_PROFILE}" iam create-access-key \
--user-name "${AWS_USER}"
{
    "AccessKey": {
        "Status": "Active",
        "UserName": "terraform",
        "CreateDate": "2020-02-12T16:09:43Z",
        "SecretAccessKey": "V3Pl9dczdxxxxxxxxxxxxxxxxxxxxxxx",
        "AccessKeyId": "AKIATPRTXXXXXXXXXXXX"
    }
}
```

### Configure Credentials

Configure the received access keys in `instance.tf`:

```
provider "aws" {
  access_key = "AKIATPRTXXXXXXXXXXXX"
  secret_key = "V3Pl9dczdxxxxxxxxxxxxxxxxxxxxxxx"
  region     = "eu-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-07042e91d04b1c30d"
  instance_type = "t2.micro"
}
```

Note: verify the ami id, as they may change over time.

### Deploy with Terraform

Initialize terraform:

```
$ terraform init
```

Once the provider data has been deownloaded, run a plan:

```
$ terraform plan
```

This will show you what terraform will be doing, once you are happy, apply:

```
$ terraform apply

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_instance.example: Creating...
aws_instance.example: Still creating... [10s elapsed]
aws_instance.example: Still creating... [20s elapsed]
aws_instance.example: Still creating... [30s elapsed]
aws_instance.example: Still creating... [40s elapsed]
aws_instance.example: Creation complete after 50s [id=i-05011b14149a4460f]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

We can use the aws cli tools to describe the instance:

```
$ aws --profile personal ec2 describe-instances
{
    "Reservations": [
        {
            "OwnerId": "xxxxxxxxxxxx",
            "Groups": [],
            "Instances": [
                {
                    "InstanceId": "i-05011xxxxxxxxxxxx",
                    "PrivateDnsName": "ip-172-31-28-102.eu-west-1.compute.internal",
                    "InstanceType": "t2.micro",
                    "Monitoring": {
                        "State": "disabled"
                    },
...
                }
            ]
        }
    ]
}
```

Clean up, by deleting the resource that was provisioned by terraform:

```
$ terraform destroy -auto-approve
```
