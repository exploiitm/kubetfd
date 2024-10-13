# Microk8s framework for CTFs

## Installation

Ubuntu installation will be the easiest

```bash
sudo snap install microk8s --classic --channel=1.31
```

To check the installation

```bash
microk8s status --wait-ready
```

As a followup

```bash
sudo usermod -a -G microk8s $USER

mkdir -p ~/.kube

chmod 0700 ~/.kube
```

Now restart. You need to RESTART logging out and then logging in won't work!

Check that `kubectl` is working. Note that microk8s has its own version.

``` bash
microk8s kubectl get nodes

microk8s kubectl get services
```


## Add other nodes

You need to run the instructions shown on the other computer. They need to be on
the same network.

``` bash
microk8s add-node
```


## Enable nginx-ingress

This allows us to forward ports to the pods on just connecting to the host IP.

Enable ingress and check if it works:

``` bash
microk8s enable ingress

microk8s kubectl get pods -A | grep ingress

microk8s kubectl -n ingress get configmap
```


## Enable dashboard

``` bash
microk8s enable dashboard
sudo microk8s kubectl get services -n kube-system
```

### Using the dashboard

``` bash
sudo microk8s kubectl describe secret -n kube-system microk8s-dashboard-token | grep ^token 
# save the token in your clipboard; you'll need it later
microk8s kubectl port-forward -n kube-system service/kubernetes-dashboard --address 0.0.0.0 10443:443
```

Now it should be accessible on port 10443. It'll ask for the token that you got
from the above command.



## Using the template

Inside the root folder, create another folder for creating the challenges.
Next, run `./create_template.sh <folder> <chall-name> <xport> <cport>` to create
the folder for the challenge. `xport` is the port on the host and `cport` is the
port in the container where the challenge is hosted.

Now cd into the folder and run `./run.sh <chall-name>`. Keep it the same as the
above for consistency. I have no idea what happens if the name is kept to a 
different one.

That's it! Now use the dashboard to check the pod status!


# TODO

- [ ] Once local docker registry is enabled, reflect the changes to pull from 
      there instead.
