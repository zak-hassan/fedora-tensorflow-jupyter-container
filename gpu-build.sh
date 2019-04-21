IMAGE_NAME=fedora-28-tf2.0-gpu
REPO_URL=quay.io/zmhassan/fedora28:tensorflow-gpu-2.0.0-alpha0
docker build --build-arg TF_WHEEL="tensorflow-gpu==2.0.0-alpha0" --rm -t  $IMAGE_NAME  .
docker build --rm -t  $IMAGE_NAME  .
docker tag  $IMAGE_NAME $REPO_URL
docker push  $REPO_URL

