#!/bin/ash

cookie_file=/tmp/lzc_cookie

case $1 in
    "list_box")
        curl "http://127.0.0.1:7777/box_list"
        ;;
    "del_box")
        read -s -p "Input your Box Name: " box
        curl -X DELETE "http://127.0.0.1:7777/del_box?bname=$box"
        ;;
    "add_tfa")
        read -p "Input your Box Name: " box
        read -p "Input your 2fa code: " auth
        curl -X POST "http://127.0.0.1:7777/add_tfa?bname=$box&tfa=$auth"
        ;;
    "add_box")
        read -p "Input your Box Name: " box
        read -p "Input your username: " uid
        read -s -p "Input your password: " pw
        curl -X POST "http://127.0.0.1:7777/add_box?bname=$box&uid=$uid&password=$pw"
        ;;
    "client_info")
        curl "http://127.0.0.1:7777/client_info"
        ;;
    "login")
        read -p "Input your Box Name: " box
        read -p "Input your username: " username
        read -s -p "Input your password: " password
        curl -x http://127.0.0.1:61090 \
          -X POST \
          -d "username=${username}" \
          -d "password=${password}" \
          -c ${cookie_file} \
          "https://${box}.heiyu.space/sys/login"
        ;;
    "visit")
	read -p "Input your test visit url: " uri
        curl -x http://127.0.0.1:61090 \
	  -b ${cookie_file} \
	  "${uri}"
	;;
    "build_docker_image")
        read -p "Input your docker image name which you want to build: " img_name
        read -p "Input the Bin download url: " dl_uri
        wget ${dl_uri} -O ./tmp/hclient-cli
        chmod +x ./tmp/hclient-cli
        docker build -t ${img_name} -f Dockerfile .
        ;;
    *)
        echo "Usage: $0 {list_box|del_box|add_tfa|add_box|client_info|build_docker_image}"
        exit 1
        ;;
esac
