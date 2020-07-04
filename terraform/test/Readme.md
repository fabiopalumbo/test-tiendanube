# Terratest

![alt text](https://blog.octo.com/wp-content/uploads/2019/03/terratest_tdd_en.png "Terratest")

Terratest is a Go library that makes it easier to write automated tests for your infrastructure code. It provides a variety of helper functions and patterns for common infrastructure testing tasks, including:

* Testing Terraform code
* Working with AWS APIs
* Working with Kubernetes APIs

![img]

## Installation
To discover the Terratest library you can clone its Git repository. The code repository contains both modules and many examples. The examples give a good idea of what the tool can do and are a good starting point.

Terratest being a Go library, it is obviously necessary to have it installed on your machine. To install the Terratest library modules it is preferable to use a dependency manager such as dep.

Getting Started
First things first you’ll need a recent version of the Go language installed. If you’re on a Mac you can install one easily using Homebrew:

```
$ brew update
$ brew install go
```
Next install the dep dependency management tool so we can add Terratest to the project.
```
$ brew install dep
```
We can therefore install the module that will be used to test Terraform in this way:
```
dep ensure -add github.com/gruntwork-io/terratest/modules/terraform
```
Or like this with go get:
```
go get github.com/gruntwork-io/terratest/modules/terraform
```
It is advisable to describe all dependencies in the Gopkg.toml file, this also allows you to fix the version of the dependencies.

Then make sure you have the necessary access to your cloud provider, in our case, we use AWS and load the environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY. We’ll also make sure we have a private key/public key pair to connect to the created machines and have our public key in AWS. For this example, we named the key “terratest_key”

Finally, we’ll create a project with files structured in this way:

```
repo/
----/main.tf
----/terratest/
----/.terraform/
```

## Run Test

*go test -v my_test.go.
```
TestEc2InstanceProvisioningWithRandomRegion 2018-07-14T21:42:16+02:00 command.go:96: Destroy complete! Resources: 1 destroyed.

...

--- PASS: TestEc2InstanceProvisioningWithRandomRegion (106.61s)

....
--- PASS: TestEc2InstanceProvisioning (127.41s)
PASS

ok  terraform-examples/test 127.432s
```
