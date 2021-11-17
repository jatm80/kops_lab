# Lab 


## Requirements

terraform\
kubectl\
kops\
jq \
make \
awscliv2

## How to Use it

Step 1: Build the docker image and push to docker hub
> make build

Step 2: Build the Kubernetes Cluster (with Kops)
> make build_infra

Step 3: Configure Nginx Ingress Controller + NLB
> make config_ingress

Step 4: Deploy the Application to Kubernetes cluster
> make deploy_app

note: default environment variable AWS_PROFILE is `aws-cert1`, in order to deploy your own stack, make sure to adjust this environment variable based on your local environment settings 

## Acceptance criteria

- [x] When I visit [http://your-link](http://your-link), I should receive a successful response .
- [x] I can spin up my own stack with provided instructions, infrastructure as code and automation.
- [x] README file, containing assumptions, design considerations and tradeoffs. 

## Design Considerations

- Standard scripting using Makefile and bash that will permit the easy integration to CI/CD Pipelines
- Kubernetes Kops was chosen as underlying target infraestructure
- Terraform was used for the deployment of application into Kubernetes
- Codebase is located in `src` folder
- Scripts are located in `scripts` folder
- Terraform files are located in `tf` folder
- SSL Certificate was not included


## Tradeoffs

- Due to the use of Terraform for the deployment of application into Kubernetes 1.22, it was not possible to create the Ingress object using `kubernetes_ingress` terraform resource, instead I had to opt for the deployment of ingress using manifest file. 
  
```
Due to ~~~ https://kubernetes.io/docs/reference/using-api/deprecation-guide/#ingress-v122  ~~~


  Terraform throws the error:
  Error: Failed to create Ingress 'helloworld/helloworld' because: the server could not find the requested resource (post ingresses.extensions) 
```


## Assumptions

- CI/CD pipeline will have the right IAM role permissions to be able to create the infraestructure in AWS using Kops
- Region is ap-southeast-2
- Hosted Zone is already created in Route53  

## 

