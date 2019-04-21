# fedora28-tensorflow2.0-cpu

This repository is for demonstration purposes and it is a work in progress. If you would like to try this and give feedback. You can open an issue.

### Kubernetes deployment


* Deploying tensorflow 2.0 in fedora container with jupyter notebook
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: jp-notebook
  labels:
    app: jupyter-notebook-pvc
spec:
  containers:
  - name: jp-notebook
    image: quay.io/zmhassan/fedora28-tensorflow2.0-cpu
```

* If you would like to mount some data into your notebook:

```yaml

apiVersion: v1
kind: Pod
metadata:
  name: jp-notebook
  labels:
    app: jupyter-notebook-pvc
spec:
  containers:
  - name: jp-notebook
    image: quay.io/zmhassan/fedora28-tensorflow2.0-cpu
    volumeMounts:
      - name: my-pvc-nfs
        mountPath: "/opt/tensorflow/src/data"
  volumes:
  - name: my-pvc-nfs
    persistentVolumeClaim:
      claimName: nfs
```

You will need to create the persistent volume and persistent volume claim like so:

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteMany
  nfs:
    server: 0.0.0.0        # Replace 0.0.0.0 with ip of your nfs server
    path: "/placeholder"   # replace 'placeholder' with actual path to your training dataset  

---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: nfs
spec:
  accessModes:
    - ReadWriteMany
  storageClassName: ""
  resources:
    requests:
      storage: 10Gi
```


