# k8s-cluster-ops-v2

## Run the project
Pre-requisite: terraform CLI and aws CLI installed
1. Configure aws cli
```
aws configure --profile=mocha
```
2. Now follow the steps in terraform/backend/README.md


## Challenges
1. Storing state in s3 for 3 AZ replication
2. using common folder for shared provider configuration and backend state management as tf treats all folders as independent modules.
so if we didnt had the common folder, we couldnt share the providers and backend state and we would require to add providers and backend state in all folders we create.
i used terraform_remote_state, it isn't for storage of your state its for retrieval in another terraform plan if you have outputs. 
later i saw tf modules which is way better https://stackoverflow.com/questions/58547168/using-terraform-remote-state-in-s3-with-multiple-folders