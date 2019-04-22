# Fedora Tensorflow Container

This repository is experimental and only for demonstration purposes. It is a work in progress.


To build custom fedora container with custom wheel file:

```bash
docker build --build-arg TF_WHEEL="..." --rm -t  $IMAGE_NAME  .  
# Replace TF_WHEEL="..." with the url to the optimized wheel file

```

### Kubernetes deployment

Below I provide instructions on how to use this container images:

```
quay.io/zmhassan/fedora28:tensorflow-cpu-2.0.0-alpha0
```

## CPU TF 

* Deploying tensorflow 2.0 in fedora container with jupyter notebook with custom wheel
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
    image: quay.io/zmhassan/fedora28:tensorflow-cpu-2.0.0-alpha0
```

## GPU TF 

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: jp-notebook
spec:
  containers:
  - name: jp-notebook
    image: tensorflow/tensorflow:nightly-gpu-py3-jupyter
    resources:
      limits:
       nvidia.com/gpu: 1
```

## Loading Training Data

Often when working with machine learning you will need access to large datasets. Kubernetes makes that easy with persistent volumes and
persistent volume claims. You can attach your notebook to cloud storage, nfs, cephfs. I provide an example how you can attach to NFS 
storage:

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
    image: tensorflow/tensorflow:nightly-gpu-py3-jupyter
    volumeMounts:
      - name: my-pvc-nfs
        mountPath: "/tf/data"
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


