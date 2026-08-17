# Getting started

This repository is a sample application for users following the getting started guide at https://docs.docker.com/get-started/.

The application is based on the application from the getting started tutorial at https://github.com/docker/getting-started

# Installation  Minikube

``` $ curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64 ```

``` $ sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64 ```

# Docker

1.  Build imagge

``` $ docker build . ```

2. Build imange and tag

``` $ docker build . -t my_image ```

4.  List images Docker

``` $ docker images ```

5. List network Docker

``` $ docker network ls ```

6. Create a network Docker

``` $ docker network create --driver bridge my-bridge cb2cfcb6b07220e308c6b292ba751deeab8a56ebbd5d6655008a01e1a82d9bf9 ```

7. Inspect bridge

``` $ docker network inspect my-bridge ```

8.  Connect two containers to this network

``` $ docker run -dit --name alpine1 --network my-bridge alpine ```

``` $ docker run -dit --name alpine2 --network my-bridge alpine ```

9. Ping the other container

``` $ docker exec alpine1 ping -c 1 172.20.0.3 ```

``` $ docker exec alpine2 ping -c 1 172.20.0.2 ```



``` $ docker exec alpine1 ping -c 1 alpine2 ```

``` $ docker exec alpine2 ping -c 1 alpine1 ```

# Minikube/Kunernetes

1. Start Docker

``` $ sudo service docker start ```

2. Start Minikube

``` $ minikube start ```

3. Status minikube

``` $ minikube status ```

4. Pods minikube

``` $ minikube kubectl -- get pods -A ```

5. Deploy container

``` $ eval $(minikube docker-env) ```

``` $ docker build . -t my_image ```

``` $ minikube kubectl -- create deployment hello-minikube --image=my_image ```

``` $ minikube kubectl -- expose deployment hello-minikube --type=LoadBalancer --port=3000 ```

6. Enabled registry minikube

``` $ minikube addons enable registry ```

7. Make your registry accessible

``` $ minikube kubectl -- port-forward --namespace kube-system service/registry 5000:80 ```

8.  List image in your registry

``` $ curl http://localhost:5000/v2/_catalog ```

9. Tag and push your image on your registry

``` $ docker build . --tag localhost:5000/my_first_image ```

``` $ docker push localhost:5000/my_first_image ```

10. View config minikube cluster

``` $ minikube kubectl -- config view ```

11. Display current context

``` $ minikube kubectl -- config current-context ```

12.  Deploy your pod

``` $ minikube kubectl -- run nginx --image=nginx --port=80 ```

13. Connect to your pod and exec a command

``` $ minikube kubectl -- exec nginx --  curl  http://localhost  ```

14. Scale pod

``` $ minikube kubectl -- run nginx2 --image=nginx --port=80 ```

``` $ minikube kubectl -- run nginx3 --image=nginx --port=80 ```

``` $ minikube kubectl -- run nginx4 --image=nginx --port=80 ```

``` $ minikube kubectl -- run nginx5 --image=nginx --port=80 ```

15. Deployment with file yaml

``` $ minikube kubectl -- apply -f site-deployement.yaml ```

16. Display your deployments

``` $ minikube kubectl -- get deploy ```

17. Delete one pod in your deployement

``` $ minikube kubectl -- delete pod/my-website-deployment-5485fcc968-4mwds ```

18. Display logs from one pod with kubectl logs

``` $ minikube kubectl -- logs nginx ```

19. Display logs from all pods with the label app : my-website

``` $ minikube kubectl -- logs -l app=my-website ```

20. Display informations from one pod

``` $ minikube kubectl -- describe pod/my-website-deployment-5485fcc968-6dr4k ```

21. Display informations from one deployment

``` $ minikube kubectl -- describe deploy/my-website-deployment ```

22. Display events kube

``` $ minikube kubectl -- get events ```

with filters

``` $ minikube kubectl -- get events --field-selector=involvedObject.kind=Pod ```

23. Deploy service kube

``` $ minikube kubectl -- apply -f site-ecommerce-service.yaml ```

24. Display all services on kube

``` $ minikube kubectl -- get services ```

25. Display informations from one service

``` $ minikube kubectl -- describe deploy/my-website-service ```

26. Check service work with the pods

``` $ minikube kubectl -- exec deploy/my-website-deployment -- wget -O - http://my-website-service.default.svc.cluster.local  ```

27. Expose the service locally (port-forward)

``` $ minikube kubectl port-forward service/my-website-service 3000:80 ```

The application is then accessible on [http://localhost:3000](http://localhost:3000).

> ⚠️ This command is intended for local development/debugging. It blocks the terminal while running (press Ctrl+C to stop) and is not suitable for production use.

28. Display Volume and  Volume Claim

``` $ minikube kubectl -- get pv ```

``` $ minikube kubectl -- get pvc ```

29. Display configmaps

``` $ minikube kubectl -- get configmap ```

30. Create Secret

``` $ minikube kubectl -- create secret generic my-website-secret --from-literal=MYSQL_PASSWORD=password ```

31. Display secrets

``` $ minikube kubectl -- get secrets ```

32. Enable ingress

``` $ minikube addons enable ingress ```

33. Dislay ingress

``` $ minikube kubectl -- get ingress ```


# Kubernetes Service Types

| Service Type | Accessibility | Use Case | Notes |
|---|---|---|---|
| **ClusterIP** | Internal to the cluster only | Internal applications, single stable entry point for a set of pods | Default service type if none is specified. Not reachable from outside the cluster. |
| **NodePort** | Internal and external (via `<NodeIP>:<NodePort>`) | Testing, limited access, direct access to pods without a load balancer | Opens a static port (range **30000–32767**) on every node. Simple but not recommended for production traffic. |
| **LoadBalancer** | External (via an external load balancer) | Public-facing applications, high availability | Provisions a cloud provider load balancer (AWS ELB, GCP LB, Azure LB, etc.). Not available on bare local clusters like Minikube without an add-on (e.g. `minikube tunnel`). |
| **ExternalName** | External (via DNS) | Redirecting to external services, traffic migration | No proxying or port mapping — it maps the service name to an external DNS name via a CNAME record. No selectors or endpoints involved. |

## Quick reference

- **ClusterIP → NodePort → LoadBalancer** can be thought of as increasing levels of external exposure — each type builds on the previous one under the hood.
- **Ingress** is not a service type itself, but it's often used alongside `ClusterIP` services to expose multiple services externally through a single entry point, with routing rules (paths, hostnames) and often TLS termination.
- On managed cloud clusters (EKS, GKE, AKS), `LoadBalancer` is the most common choice for production. On local clusters (Minikube, kind), it's mainly used for testing via workarounds like `minikube tunnel`.