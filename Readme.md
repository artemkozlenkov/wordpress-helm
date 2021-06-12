## Wordpress kube dev

Reusing: 

_[oficial helm wordpress charts](https://github.com/helm/charts/tree/master/stable/wordpress)_

_[oficial docker wordpress bitnami](https://github.com/bitnami/bitnami-docker-wordpress)_

#### Prerequisites:
> Minikube, Helm, docker, kubectl, git, wget

#### Start
1. to start the cluster, please run in your terminal
```shell
./wp.sh up
```

2. to delete the cluster, please run the command
```shell
./wp.sh down
```

#### Usage

After the command from [Start](#Start) has successfully completed you may find 
**username** and **password** in the console output.

### Limitations: 

- database not persisted, once you run `./wp.sh down` all changes will be lost.
