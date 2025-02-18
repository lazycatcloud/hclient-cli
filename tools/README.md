# Tools

该目录提供了一些快速使用 cli 的方法

## cmd.sh

该文件主要是用来管理盒子的, 基本与盒子管理的 API 一一对应.

使用方法为

```
./cmd.sh sub_command
```

> sub_command 即对应的管理接口名称

## 构建 Docker 镜像

查看最新版本的 tag, 比如目前的最新版本的 tag 为 20250514, 则执行下面的命令开始编译.

```
./build.sh 20250514
```

编译后, 可以得到名字为 `hclient-cli:latest` 的镜像, 然后就可以使用该镜像启动容器了.

> 该镜像同时把 `cmd.sh` 也封装进了镜像, 所以可以在容器中直接使用 `/app/cmd.sh` 命令.

## 启动容器

下面是一个以代理模式启动容器的 Demo 

```
docker run -itd \
    --name lazycat \
    --hostname lazycat_in_docker \
    --restart always \
    -p 127.0.0.1:7777:7777 \
    -p 127.0.0.1:61090:61090 \
    -v /data/cfg:/app/cfg \
    hclient-cli:latest \
    /app/hclient-cli \
      -cfg "/app/cfg" \
      -api-addr "127.0.0.1:7777" \
      -http-addr "127.0.0.1:61090"
```

> 请注意不要暴露你的 7777 管理端口和 61090 代理端口给全局网络

Demo 容器启动后, 宿主机可以通过 `127.0.0.1:7777` 管理, 通过 `127.0.0.1:61090` 代理访问.
