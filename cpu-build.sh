IMAGE_NAME=fedora-28-tf2.0-cpu
REPO_URL=quay.io/zmhassan/fedora28:tensorflow-cpu-2.0.0-alpha0
docker build --rm -t  $IMAGE_NAME  .
docker tag  $IMAGE_NAME $REPO_URL
docker push  $REPO_URL

