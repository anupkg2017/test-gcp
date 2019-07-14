docker build -t anupkg2017/client:latest -t anupkg2017/client:$SHA  -f ./client/Dockerfile ./client
docker build -t anupkg2017/server:latest -t anupkg2017/server:$SHA -f ./server/Dockerfile ./server
docker build -t anupkg2017/worker:latest -t anupkg2017/worker:$SHA -f ./worker/Dockerfile ./worker

docker push anupkg2017/client:latest
docker push anupkg2017/server:latest
docker push anupkg2017/worker:latest
docker push anupkg2017/client:$SHA
docker push anupkg2017/server:$SHA
docker push anupkg2017/worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment.yaml server=anupkg2017/multi-server:$SHA
kubectl set image deployments/client-deployment.yaml client=anupkg2017/multi-client:$SHA
kubectl set image deployments/worker-deployment.yaml worker=anupkg2017/multi-worker:$SHA