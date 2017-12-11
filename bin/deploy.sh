#!/bin/bash
set -e

export ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

pushd $ROOT > /dev/null

set +e
kubectl delete configmap ethermint-config
kubectl delete configmap tendermint-config
kubectl delete secret tendermint-secrets
set -e

kubectl create configmap ethermint-config \
  --from-file=config/ethereum-genesis.json

kubectl create configmap tendermint-config \
  --from-file=config/tendermint-genesis.json \
  --from-file=config/tendermint-config.toml

kubectl create secret generic tendermint-secrets \
  --from-file=config/node-0.priv_validator.json \
  --from-file=config/node-1.priv_validator.json \
  --from-file=config/node-2.priv_validator.json \
  --from-file=config/node-3.priv_validator.json

kubectl apply --recursive -f ./manifests
