# 简单的ubuntu docker环境

docker file to build a simple dev container

## Usage

```git clone https://github.com/zzsuki/ubuntu-with-sshd.git && cd ubuntu-with-sshd.git```

by default ...
- the container will be built with ubuntu:18.04 image, you can change it in the Dockerfile
- the container will be have two user(root and zzsuki), password of root can be change in env. and zzsuki's password in useradd line
- the container will allow login as root, you can change it at first sed line if you don't like it

```docker build -t ubuntu-with-sshd .```

### build

```bash
docker build -t ubuntu1804:dev .
```

### run

```bash
docker run -d --name ubuntu -p 2222:22 ubuntu1804:dev
```


## delete
docker stop ubuntu && docker rm ubuntu

## Additions

...
