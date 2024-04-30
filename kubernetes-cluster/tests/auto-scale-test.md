# Auto Scaling Test

This document describes the test for the auto scaling feature of the Kubernetes cluster.

## Deployment Configuration

The following is the configuration for the deployment:
```

apiVersion: apps/v1
kind: Deployment
metadata:
 name: test-dep
 labels:
   app: test-dep
spec:
 replicas: 3
 selector:
   matchLabels:
     app: test-dep
 template:
   metadata:
     labels:
       app: test-dep
   spec:
     containers:
     - name: test-dep
       image:  mcr.microsoft.com/aks/command/runtime:master.240118.1
       command: ["sleep"]
       args: ["72000"]
       resources:
         requests:
           memory: "1G"
           cpu: "1000m"
         limits:
           memory: "2G"
           cpu: "3000m"
 strategy:
   type: RollingUpdate
   rollingUpdate:
     maxUnavailable: 1
```
## Commands to test 
    kubectl apply -f test-dep.yaml
    kubectl get nodes
    kubectl get pods
    kubectl scale deployments test-dep --replicas=40
    kubectl get pods
    sleep 300
    kubectl get nodes
