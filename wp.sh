#!/bin/bash -e

# btinami/wordpress https://github.com/helm/charts/tree/master/stable/wordpress

readonly WP=wp
readonly NS=$WP

#with Minikube local development environment we need to use NodePort as the ServiceType
if [ $1 == 'up' ]; then

helm repo add bitnami https://charts.bitnami.com/bitnami
kubectl create namespace $NS
helm install $WP --namespace $NS --set serviceType=NodePort bitnami/wordpress

export NODE_PORT=$(kubectl get --namespace $NS -o jsonpath="{.spec.ports[0].nodePort}" services $WP-wordpress)
export NODE_IP=$(kubectl get nodes --namespace $NS -o jsonpath="{.items[0].status.addresses[0].address}")


#healthchecking pods
while [[ $(kubectl -n $NS get pods -l app.kubernetes.io/name=mariadb -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do
  echo "waiting for mariadb" && sleep 1;
done

while [[ $(kubectl -n $NS get pods -l app.kubernetes.io/name=wordpress -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do
  echo "waiting for wordpress" && sleep 1;
done

sensible-browser http://$NODE_IP:$NODE_PORT/admin

echo http://$NODE_IP:$NODE_PORT/admin
echo Password: $(kubectl get secret --namespace $NS $WP-wordpress -o jsonpath="{.data.wordpress-password}" | base64 --decode)
fi;

if [ $1 == 'down' ]; then
    helm delete $WP -n $NS
    kubectl delete namespace $NS
fi