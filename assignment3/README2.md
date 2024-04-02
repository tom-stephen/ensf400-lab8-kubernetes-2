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
The NGINX Service (`nginx-svc.yaml`) creates a ClusterIP service named `nginx-svc` that exposes port 8080 and selects the NGINX pods using label selectors.

## 4. NGINX Ingress <a name="nginx-ingress"></a>
The NGINX Ingress (`nginx-ingress.yaml`) configures an Ingress resource to redirect requests to path `/nginx` to the NGINX service (`nginx-svc`).

## 5. Application Deployments <a name="application-deployments"></a>
Deployment YAML files (`app-1-dep.yaml` and `app-2-dep.yaml`) define `app-1` and `app-2`, respectively. They use pre-built Docker images (`ghcr.io/denoslab/ensf400-sample-app:v1` and `ghcr.io/denoslab/ensf400-sample-app:v2`).

## 6. Application Services <a name="application-services"></a>
Service YAML files (`app-1-svc.yaml` and `app-2-svc.yaml`) define ClusterIP services for `app-1` and `app-2`, respectively, exposing port 8080.

## 7. Application Ingresses <a name="application-ingresses"></a>
Ingress YAML files (`app-1-ingress.yaml` and `app-2-ingress.yaml`) configure Ingress resources to redirect requests to path `/app` to the backend services of `app-1` and `app-2`, respectively.

## 8. Startign the application <a name="startign-the-applicatio"></a>
to start tthe application you should go to the assignment diecotry and once in that directory run the following to start the application.

```bash
kubectl apply -f .
```

to stop the application run the following:
```bash
kubectl delete -f .
```

## 9. Testing <a name="testing"></a> 
To test the deployment, you can use `curl` to send requests to the NGINX and application services. Here are some sample commands:

###   <span style="color:red">NOTE: This does not work. not sure why yet.</span>
### Testing NGINX Ingress:
```bash
curl http://<ingress-host>/nginx
