# Tools

该目录提供了一些快速使用 cli 的方法

## cmd.sh

该文件主要是用来管理盒子的，基本与盒子管理的 API 一一对应。

使用方法为

```
./cmd.sh sub_command
```

> sub_command 即对应的管理接口名称

## Docker

为了方便容器应用访问，可以把 hclient-cli 包装在一个单独的容器中，使其与你的应用容器在同一个 docker 网络下，这样应用容器可以通过代理访问到懒猫的 ingress 端口资源。

在 `cmd.sh` 中提供了简单的一个封装，你可以根据自己的需求调整 `Dockerfile`.

下面是一个启动容器的 Demo 

```
docker run -itd \
    --privileged \
    --name lazycat \
    --hostname lazycat_in_docker \
    --restart always \
    --network lnmp \
    --ip 172.20.0.66 \
    -p 127.0.0.1:7777:7777 \
    -p 127.0.0.1:61090:61090 \
    -v /data/cfg:/app/cfg \
    ety001/lazycat-cli:latest \
    /app/hclient-cli \
      -api-addr "172.20.0.66:7777" \
      -http-addr "172.20.0.66:61090"
```

> 请注意不要暴露你的 7777 管理端口和 61090 代理端口给全局网络

Demo 容器启动后，所有 lnmp 网络中的容器可以通过 `172.20.0.66:61090` 代理访问懒猫资源。

宿主机可以通过 `127.0.0.1:7777` 管理，通过 `127.0.0.1:61090` 代理访问。
