The code is for creating a basic python app that keeps doing factorial for a specific time.
you can send the specific time as a payload and start this task, 
once u fire the api u can see HPA doing its job by scaling up pods as per necessity

create the image
```
docker build -t <your-dockerhub-username>/cpu-intensive-app:latest .
docker push <your-dockerhub-username>/cpu-intensive-app:latest
```

make sure to replace my username with your-dockerhub-username in deployment.yaml
```
kubectl apply -f cpu-intensive-app-deployment.yaml
kubectl apply -f cpu-intensive-app-svc.yaml
kubectl apply -f cpu-intensive-app-hpa.yaml
```


i port fowarded request
```
kubectl port-forward svc/cpu-intensive-app 8080
```

call the rest api
```
curl -X POST -H "Content-Type: application/json" -d '{"duration": 60}' http://localhost:8080/trigger
```

and open terminals and watch hope pods scale up 
```
kubectl get pods -w
kubectl get hpa -w
```

you can refer attached png images