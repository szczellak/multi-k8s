docker build -t szczellak/multi-client:latest -t szczellak/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t szczellak/multi-server:latest -t szczellak/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t szczellak/multi-worker:latest -t szczellak/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push szczellak/multi-client:latest
docker push szczellak/multi-server:latest
docker push szczellak/multi-worker:latest

docker push szczellak/multi-client:$SHA
docker push szczellak/multi-server:$SHA
docker push szczellak/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=szczellak/multi-server:$SHA
kubectl set image deployments/client-deployment client=szczellak/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=szczellak/multi-worker:$SHA