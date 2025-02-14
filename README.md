# hclient-cli
## 下载
https://gitee.com/lazycatcloud/hclient-cli/releases

- 桌面64位电脑选择amd64版本
- 桌面32位电脑选择386版本
- 较新的移动平台或Apple M1等设备选择arm64版本
- 较为古老的移动平台设备选择arm版本
- risc-v平台选择riscv64版本

## 使用

启动
```shell
chmod +x ./hclient-cli-$arch # 第一次启动需要添加可执行权限
./hclient-cli-$arch
```

### 盒子管理
启动后，可以通过调用HTTP API来进行添加盒子等操作：
（下面案例使用curl）
```shell
# 添加盒子
curl -X POST http://127.0.0.1:7777/add_box?bname=%s&uid=%s&password=%s
# 设置TFA Code（两步验证码）
curl -X POST http://127.0.0.1:7777/add_tfa?bname=%s&tfa=%s
# 列举盒子
curl http://127.0.0.1:7777/box_list
# 删除盒子
curl -X DELETE http://127.0.0.1:7777/del_box?bname=%s
# 查看当前客户端信息
curl http://127.0.0.1:7777/client_info
```

### 访问盒子
无特权可以默认通过http/socks5代理访问盒子：
```shell
curl -x socks5h://127.0.0.1:61085 https://someone.heiyu.space
curl -x http://127.0.0.1:61090 https://someone.heiyu.space
```

也可以添加capability，直接启用VPN，就可以无需配置代理访问盒子：
```shell
sudo setcap cap_net_admin=ep ./hclient-cli-$arch
./hclient-cli-$arch -tun
```
