terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws" # Always unique
      version = "5.72.1" # If no version specified, latest version and the point of execution will be used
    }
  }
}

provider "aws" {
  # Configuration options
  access_key = "" # Pls note, writing out access key in clear like this isn't best practice
  secret_key = "" # Pls note, writing out Secret key in clear like this isn't best practice
  region = "us-east-2" # This is Ohio region
}

resource "aws_s3_bucket" "sampleBucket" {
  bucket = "MySecondHashtagBucket"

  tags = {
    yearOfCreation = 2024
    Environment = "Dev"
  }
} 

resource "aws_key_pair" "mySecondVmTfKeyPair" {
  key_name = "mysecondvmkeypair"
  public_key = file("C:/Users/DAMILOLA/terraformFirstKey.pub.pub")
  tags = {
    yearOfCreation = 2024    
  }
}

resource "aws_instance" "mySecondVmTf" {
  ami = "ami-0b40807e5dc1afecf"
  instance_type = "t2.micro"
  key_name = aws_key_pair.mySecondVmTfKeyPair.id
  depends_on = [ aws_key_pair.mySecondVmTfKeyPair ]
  tags = {
    yearofcreation = "2024"
  } 
}

output "myEc2Id" {
  value = aws_instance.mySecondVmTf.id
  depends_on = [ aws_instance.mySecondVmTf ]
}

output "myEc2ARN" {
  value = aws_instance.mySecondVmTf.arn
  depends_on = [ aws_instance.mySecondVmTf ]
}

output "mybucketDetails" {
  value = aws_s3_bucket.sampleBucket.arn
  depends_on = [ aws_s3_bucket.sampleBucket ]
}