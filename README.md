# hclient-cli
## 下载
https://gitee.com/lazycatcloud/hclient-cli/releases

## 使用

启动(Linux/macOS)
```shell
chmod +x ./hclient-cli-$os-$arch
./hclient-cli-$os-$arch
```

启动(Windows)
```powershell
# 首先下载 https://www.wintun.net/builds/wintun-0.14.1.zip
# 解压 wintun.dll 并放到和cli相同的目录下
# 然后执行下列命令
mv ./hclient-cli-$os-$arch ./hclient-cli-$os-$arch.exe
./hclient-cli-$os-$arch.exe
```

### 微服管理
启动后，可以通过调用HTTP API来进行添加微服等操作：
```shell
# 添加微服
curl -X POST --get --data-urlencode bname="$boxname" --data-urlencode uid="$username" --data-urlencode password="$password" http://127.0.0.1:7777/add_box
# 设置TFA Code（两步验证码）
curl -X POST --get --data-urlencode bname="$boxname" --data-urlencode tfa="$tfa_code" http://127.0.0.1:7777/add_tfa
# 列举微服
curl http://127.0.0.1:7777/box_list
# 删除微服
curl -X DELETE --get --data-urlencode bname="$boxname" 'http://127.0.0.1:7777/del_box'
# 查看当前客户端信息
curl http://127.0.0.1:7777/client_info
```

### 访问微服
默认可以通过http代理访问微服：
```shell
curl -x http://127.0.0.1:61090 https://$boxname.heiyu.space
```

在Linux平台上，推荐添加capability，在启动hclient-cli时直接启用TUN，
就可以无需配置代理访问微服：
```shell
sudo setcap cap_net_admin=ep ./hclient-cli-$os-$arch
./hclient-cli-$os-$arch -tun
```

```shell
curl https://$boxname.heiyu.space
```

### 常见问题
#### TUN模式下，客户端启动后就退出了 (Linux)
首先检查是否正确设置capability:
```shell
sudo getcap ./hclient-cli-$os-$arch
```
其次检查文件系统挂载参数是否有nosuid:
```shell
mount | grep nosuid # 查看 hclient-cli-$os-$arch 所在的目录是否在nosuid范围内
```
最后尝试手动加载TUN内核模块，并正确配置设备权限:
```shell
sudo modprobe tun
sudo chmod 666 /dev/net/tun
```
