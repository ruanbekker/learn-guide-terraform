## Variables

We will be using the terraform console to explore variables:

### Using tf files

```
$ touch variables.tf
```

In a tf file, we define a resource, we will be defining variables. In our variable block, we have different properties, a `type` which is a constraint, where only a string can be used as an input for example, the `default` value, and `description` for documentation.

We will be working with the following variables:

```
variable "string_var" {
  type = string
  default = "hello world"
}

variable "map_var" {
  type = map(string)
  default = {
    name    = "ruan",
    surname = "bekker"
  }
}

variable "string_list_var" {
  type = list
  default = ["one", "two"]
}

variable "integer_list_var" {
  type = list
  default = [1,2]
}

variable "boolean_var" {
  type = bool
  default = true
}
```

Access the terraform console:

```
$ terraform console
> 
``

Let's access our first variable, we can either use:

```
> var.string_var
hello world
```

or:

```
> "${var.string_var}"
hello world 
````

To access a map:

```
> "${var.map_var}"
{
  "name" = "ruan"
  "surname" = "bekker"
}
```

To access a specific key:

```
> "${var.map_var["name"]}"
ruan
```

To access our string list:

```
> "${var.string_list_var}"
[
  "one",
  "two",
]
```

We can also access a specific element:

```
> "${var.string_list_var[0]}"
one
```

With our integer list:

```
> "${var.integer_list_var}"
[
  1,
  2,
]
```

Accessing a specific element:

```
> "${var.integer_list_var[0]}"
1
```

And for our boolean type:

```
> "${var.boolean_var}"
true
```

### Using tfvar files

In our `resource.tf` we will introduce our aws provider that will allow us to interact with aws, we define a variable `AWS_REGION` with default values, but we can overwrite the value with a `terraform.tfvars` file.

Then we have a type of resource which is a aws_instance in our resource section. But we will only focus on the variable section.

Our `resource.tf`:

```
provider "aws" {
}

variable "AWS_REGION" {
  type    = string
  default = "us-east-1"
}

variable "AMIS" {
  type    = map(string)
  default = {
    eu-west-1 = "ami-0000001"
  }
}

resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.nano"
}
``` 

Our `terraform.tfvars` file:

```
AWS_REGION="eu-west-1"
```

As we have a new provider defined, we first need to download it by initializing it:

```
$ terraform init
```

Once that is done, enter the console:

```
$ terraform console
```

Access the `AWS_REGION` environment variable:

```
> "${var.AWS_REGION}"
eu-west-1
```

Also, accessing the AMIS variable:

```
> "${var.AMIS["${var.AWS_REGION}"]}"
ami-000001
```

Exit and remove the `terraform.tfvars` file:

```
$ rm -rf terraform.tfvars
```

Enter the console again, and access the same variable, and you will see it reverts to the default value defined in our `resource.tf`:

```
$ terraform console
> "${var.AWS_REGION}"
us-east-1
```

