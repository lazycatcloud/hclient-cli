# hclient-cli
## 下载
https://gitee.com/lazycatcloud/hclient-cli/releases

- 桌面64位电脑选择amd64版本
- 桌面32位电脑选择386版本
- 较新的移动平台或Apple M1等设备选择arm64版本
- 较为古老的移动平台设备选择arm版本
- risc-v平台选择riscv64版本

## 使用

```shell
chmod +x ./hclient-cli-$arch
./hclient-cli-$arch
```

通过HTTP API来进行添加盒子等操作：
```shell
curl -X POST http://127.0.0.1:7777/add_box?bname=%s&uid=%s&password=%s
curl -X POST http://127.0.0.1:7777/add_tfa?bname=%s&tfa=%s
curl http://127.0.0.1:7777/box_list
curl -X DELETE http://127.0.0.1:7777/del_box?bname=%s
curl http://127.0.0.1:7777/client_info
```

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
