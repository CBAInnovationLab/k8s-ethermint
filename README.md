# Ethermint Kubernetes

This repo contains the config and manifests required to deploy a 4 node ethermint chain with eth-netstats to kubernetes.

## Usage

1. Create a Kubernetes cluster on Google Cloud (make sure version is > 1.8.x)
2. Configure your `kubectl` to point to this cluster
3. Run `./bin/deploy.sh`
4. Wait for the containers to deploy and be ready

## Useful scripts

### Connect to a node
```
kubectl port-forward node-0 8545 46657

# From another terminal
geth attach http://localhost:8545
```

### Connect to stats
```
export NETSTATS_POD_NAME=$(kubectl get pods --namespace default -l "app=netstats-api" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward $NETSTATS_POD_NAME 3000

# Open http://localhost:3000 in a browser
```

### View logs
```
kubectl logs -f node-0 -c tendermint  # Follow tendermint logs for node-0
kubectl logs -f node-0 -c ethermint  # Follow ethermint logs for node-0
```
