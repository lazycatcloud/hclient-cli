# hclient-cli

## Getting Started

### Download
https://gitee.com/lazycatcloud/hclient-cli/releases

### Set up
#### Linux/macOS
```shell
chmod +x ./hclient-cli-$os-$arch
./hclient-cli-$os-$arch
```
#### Windows
```powershell
# You need to download https://www.wintun.net/builds/wintun-0.14.1.zip
# Then unpack wintun.dll, and put it in the same directory as hclient-cli
# When you're done, execute the following commands:
mv ./hclient-cli-$os-$arch ./hclient-cli-$os-$arch.exe
./hclient-cli-$os-$arch.exe
```

### Manage your microserver
```shell
# Add your microserver
curl -X POST --get --data-urlencode bname="$microserver_name" --data-urlencode uid="$username" --data-urlencode password="$password" http://127.0.0.1:7777/add_box

# Set Two Factor Authentication Code
curl -X POST --get --data-urlencode bname="$microserver_name" --data-urlencode tfa="$tfa_code" http://127.0.0.1:7777/add_tfa

# List your microservers
curl http://127.0.0.1:7777/box_list

# Delete your microserver
curl -X DELETE --get --data-urlencode bname="$microserver_name" 'http://127.0.0.1:7777/del_box'

# View client info
curl http://127.0.0.1:7777/client_info
```

### Access your microserver
With default parameter, you can access microserver with HTTP proxy:
```shell
curl -x http://127.0.0.1:61090 https://$microserver_name.heiyu.space
```

If you're using hclient-cli on Linux, you can add required capability, and launch it in TUN mode:
```shell
sudo setcap cap_net_admin=ep ./hclient-cli-$os-$arch
./hclient-cli-$os-$arch -tun
```

```shell
curl https://$boxname.heiyu.space
```

### FAQ
#### In TUN mode, hclient-cli exits right after launch (Linux)
Check your program has the required capability:
```shell
sudo getcap ./hclient-cli-$os-$arch
```
Then check the filesystem is not mounted with nosuid:
```shell
mount | grep nosuid # Check if the directory hclient-cli-$os-$arch is in is mounted with nosuid
```
Lastly you can manually load the TUN kernel module, and set up the device permission:
```shell
sudo modprobe tun
sudo chmod 666 /dev/net/tun
```
