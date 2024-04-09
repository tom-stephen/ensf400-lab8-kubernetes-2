# Deployment of NGINX and Application Services in Kubernetes

This repository contains YAML files for deploying NGINX as a reverse proxy and two application services (`app-1` and `app-2`) in a Kubernetes cluster. The NGINX service acts as a load balancer, redirecting traffic to the backend application services based on specified configurations.

## Table of Contents
1. [NGINX Deployment](#nginx-deployment)
2. [NGINX ConfigMap](#nginx-configmap)
3. [NGINX Service](#nginx-service)
4. [NGINX Ingress](#nginx-ingress)
5. [Application Deployments](#application-deployments)
6. [Application Services](#application-services)
7. [Application Ingresses](#application-ingresses)
8. [Startign the application](#startign-the-application)
9. [Testing](#testing)

## 1. NGINX Deployment <a name="nginx-deployment"></a>
The NGINX Deployment (`nginx-dep.yaml`) creates a replica set of NGINX pods with 5 replicas. It uses the NGINX base image version 1.14.2 and exposes port 8080.

## 2. NGINX ConfigMap <a name="nginx-configmap"></a>
The NGINX ConfigMap (`nginx-configmap.yaml`) defines a configuration file (`nginx.conf`) that specifies upstream servers and location directives for proxying requests.

## 3. NGINX Service <a name="nginx-service"></a>
The NGINX Service (`nginx-svc.yaml`) creates a ClusterIP service named `nginx-svc` that exposes port 80 and selects the NGINX pods using label selectors.

## 4. NGINX Ingress <a name="nginx-ingress"></a>
The NGINX Ingress (`nginx-ingress.yaml`) configures an Ingress resource to redirect requests to path `/` to the NGINX service (`nginx-svc`).

## 5. Application Deployments <a name="application-deployments"></a>
Deployment YAML files (`app-1-dep.yaml` and `app-2-dep.yaml`) define `app-1` and `app-2`, respectively. They use pre-built Docker images (`ghcr.io/denoslab/ensf400-sample-app:v1` and `ghcr.io/denoslab/ensf400-sample-app:v2`).

## 6. Application Services <a name="application-services"></a>
Service YAML files (`app-1-svc.yaml` and `app-2-svc.yaml`) define ClusterIP services for `app-1` and `app-2`, respectively, exposing port 8080 from container port 3000.

## 7. Application Ingresses <a name="application-ingresses"></a>
Ingress YAML files (`app-1-ingress.yaml` and `app-2-ingress.yaml`) configure Ingress resources to redirect requests to path `/` to the backend services of `app-1` and `app-2`, respectively.

## 8. Startign the application <a name="startign-the-applicatio"></a>
to start tthe application you should go to the assignment diecotry and once in that directory run the following to start the application.

if you are using minikube make sure to start it
```bash
minikube start
```
you also need to add ingress compatability 
```bash
minikube addons enable ingress
```
After that you can apply the kuberneties files
```bash
kubectl apply -f .
```

to stop the application run the following:
```bash
kubectl delete -f .
```

## 9. Testing <a name="testing"></a> 
To test the deployment, you can use `curl` to send requests to the NGINX and application services. Here are some sample commands:

### Testing NGINX Ingress:
```bash
curl http://$(minikube ip)/
```

in this directory there is also a bash script that curls it 100 times and shows the output of percentage of the requests that are directed to app 1 and to app 2. Note that this will not return exactly 70% and 30% becasue it is not a massive sample size. the larger the sample size the more acufrate the results would be. below is an example of the out put i got. 

#### To Run the Script:
```bash
./test.sh
```
#### My Output:
```bash
Percentage of responses from App 1: 84%
Percentage of responses from App 2: 16%
```

### Expected out come
Below if the out come that i got when running this on my computer.
```bash
Hello World from [app-1-dep-65c994b56f-tgnbp]!@tom-stephen ➜ /workspaces/ensf400-lab8-kubernetes-2/assignment3 (assignment_3) $ curl http://192.168.58.2/
Hello World from [app-1-dep-65c994b56f-tgnbp]!@tom-stephen ➜ /workspaces/ensf400-lab8-kubernetes-2/assignment3 (assignment_3) $ curl http://192.168.58.2/
Hello World from [app-2-dep-54847874cd-lslr2]!@tom-stephen ➜ /workspaces/ensf400-lab8-kubernetes-2/assignment3 (assignment_3) $ curl http://192.168.58.2/
Hello World from [app-1-dep-65c994b56f-tgnbp]!@tom-stephen ➜ /workspaces/ensf400-lab8-kubernetes-2/assignment3 (assignment_3) $ curl http://192.168.58.2/
Hello World from [app-2-dep-54847874cd-lslr2]!@tom-stephen ➜ /workspaces/ensf400-lab8-kubernetes-2/assignment3 (assignment_3) $ curl http://192.168.58.2/
Hello World from [app-1-dep-65c994b56f-tgnbp]!@tom-stephen ➜ /workspaces/ensf400-lab8-kubernetes-2/assignment3 (assignment_3) $ curl http://192.168.58.2/
Hello World from [app-1-dep-54847874cd-lslr2]!@tom-stephen ➜ /workspaces/ensf400-lab8-kubernetes-2/assignment3 (assignment_3) $ curl http://192.168.58.2/
Hello World from [app-1-dep-65c994b56f-tgnbp]!@tom-stephen ➜ /workspaces/ensf400-lab8-kubernetes-2/assignment3 (assignment_3) $ curl http://192.168.58.2/
Hello World from [app-2-dep-54847874cd-lslr2]!@tom-stephen ➜ /workspaces/ensf400-lab8-kubernetes-2/assignment3 (assignment_3) $ curl http://192.168.58.2/
```
