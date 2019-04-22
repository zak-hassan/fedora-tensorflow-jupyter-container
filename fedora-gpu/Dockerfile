FROM fedora:28

ARG TF_WHEEL=https://github.com/AICoE/tensorflow-wheels/releases/download/tf-r2.0-cpu-2019-03-06_220754/tensorflow-2.0.0a0-cp36-cp36m-linux_x86_64.whl
ENV tensorflow_wheel=$TF_WHEEL
WORKDIR /opt/tensorflow/src

RUN dnf update -y && \
    dnf install python37 python3-pip gcc -y && \
    pip3 install $TF_WHEEL jupyter

ENV PATH="/usr/local/nvidia/bin:${PATH}"
ENV LD_LIBRARY_PATH=/usr/local/nvidia/lib64

EXPOSE 8888

ENTRYPOINT ["/usr/local/bin/jupyter","notebook","--ip", "0.0.0.0","--allow-root","--notebook-dir","/opt/tensorflow/src"]
