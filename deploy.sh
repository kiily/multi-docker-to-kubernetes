docker build -t kiily/multi-client-k8s:latest -t kiily/multi-client-k8s:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t kiily/multi-server-k8s:latest -t kiily/multi-server-k8s:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t kiily/multi-worker-k8s:latest -t kiily/multi-worker-k8s:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push kiily/multi-client-k8s:latest
docker push kiily/multi-server-k8s:latest
docker push kiily/multi-worker-k8s:latest

docker push kiily/multi-client-k8s:$GIT_SHA
docker push kiily/multi-server-k8s:$GIT_SHA
docker push kiily/multi-worker-k8s:$GIT_SHA

# Can use kubectl as this runs in travis
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=kiily/multi-client-k8s:$GIT_SHA
kubectl set image deployments/server-deployment server=kiily/multi-server-k8s:$GIT_SHA
kubectl set image deployments/worker-deployment worker=kiily/multi-worker-k8s:$GIT_SHA