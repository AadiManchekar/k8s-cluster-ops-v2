1. Create a s3 bucket to store backend state, in this repo i have mocha-eks-state as my s3 bucket. (you can have versioning enabled but then make sure you enable AWS S3 lifecycle policies.)
2. Once u have s3 bucket replace "mocha-eks-state" with your s3 bucket name everywhere in backend folder
```
terraform plan
terraform validate
terraform apply
```
3. Check your s3 bucket it will have state stored

Now you can probably use DynamoDB for state locking. But hey lets keep this project a bit simpler and straight to the point.
