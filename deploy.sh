docker build -t rickthomas1980/multi-client:latest -t rickthomas1980/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rickthomas1980/multi-server:latest -t rickthomas1980/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rickthomas1980/multi-worker:latest -t rickthomas1980/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rickthomas1980/multi-client:latest
docker push rickthomas1980/multi-server:latest
docker push rickthomas1980/multi-worker:latest

docker push rickthomas1980/multi-client:$SHA
docker push rickthomas1980/multi-server:$SHA
docker push rickthomas1980/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rickthomas1980/multi-server:$SHA
kubectl set image deployments/client-deployment client=rickthomas1980/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rickthomas1980/multi-worker:$SHA
