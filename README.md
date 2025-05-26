# hclient-cli
## 下载
https://gitee.com/lazycatcloud/hclient-cli/releases

- 桌面64位电脑选择amd64版本
- 移动平台或Apple M1等设备选择arm64版本

## 使用

启动
```shell
chmod +x ./hclient-cli-$arch # 第一次启动需要添加可执行权限
./hclient-cli-$arch
```

帮助信息
```
Usage of ./hclient-cli-$arch:
  -cfg string
    	配置文件路径 (default "./cfg/")
  -api-addr string
    	API监听地址,支持 (default "127.0.0.1:7777")
  -disable-api
    	不开启API配置服务器,建议仅在第一次运行时开启配置,然后关闭API server
  -tun
    	是否开启系统tun模式,开启后系统层面可以直接访问微服资源.
  -http-addr string
    	提供的http服务器地址 (default "127.0.0.1:61090")
  -http-user string
    	http代理设置auth用户名
  -http-password string
    	http代理设置auth密码（为空则随机生成）
```

### 微服管理
启动后，可以通过调用HTTP API来进行添加微服等操作：
（下面案例使用curl）
```shell
# 添加微服
curl -X POST 'http://127.0.0.1:7777/add_box?bname=%s&uid=%s&password=%s'
# 设置TFA Code（两步验证码）
curl -X POST 'http://127.0.0.1:7777/add_tfa?bname=%s&tfa=%s'
# 列举微服
curl 'http://127.0.0.1:7777/box_list'
# 删除微服
curl -X DELETE 'http://127.0.0.1:7777/del_box?bname=%s'
# 查看当前客户端信息
curl 'http://127.0.0.1:7777/client_info'
```

### 访问微服
无特权可以默认通过http代理访问微服：
```shell
curl -x 'http://127.0.0.1:61090' 'https://$someone.heiyu.space'
```

推荐添加capability，在启动hclient-cli时直接启用VPN，
就可以无需配置代理访问微服：
```shell
sudo setcap cap_net_admin=ep ./hclient-cli-$arch
./hclient-cli-$arch -tun
```
