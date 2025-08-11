
## Deploying with Minikube

1. Install Docker Desktop
Instructions on the Docker website [here](https://docs.docker.com/desktop/setup/install/mac-install/)
2. Install minikube
	```brew install minikube```
3. Start minikube
 ```minikube start```
4. Create deployment
 ```kubectl apply -f kubernetes/deployment.yaml```
5. Check pods
```kubectl get pods```
Response should be something like
```
NAME  						READY 	STATUS  	RESTARTS 	AGE
django-app-588767f857-s5769 1/1 	Running 	0  			18s
```
6. In a separate terminal window, run
 ```minikube tunnel```
7. From your original window, deploy the service 
 ```kubectl apply -f kubernetes/service.yaml```
8. Check that the service was created successfully
```kubectl get services```
The response should look something like this. note the Django service's external IP (127.0.0.1)
```
NAME 			TYPE 			CLUSTER-IP  	EXTERNAL-IP 	PORT(S)  		AGE
django-service 	LoadBalancer 	10.105.54.182 	127.0.0.1 		80:32144/TCP 	5s
kubernetes 		ClusterIP  		10.96.0.1 		<none>  		443/TCP  		10m
```
9. Open Your browser to the external IP address
10. If you receive an error, check your terminal window that ran `minikube tunnel`, you likely have to enter your password.
11. When you're done, don't forget to run ```minikube down```