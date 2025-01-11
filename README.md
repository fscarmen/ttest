# CFD 反向回源一键脚本

一个基于 Cloudflare Tunnel 的双向流量回源工具，支持 CentOS、Debian、Ubuntu、Alpine 和 OpenWRT 系统。

* * *

# 目录

- [1.特点](README.md#1特点)
- [2.支持的操作系统和架构](README.md#2支持的操作系统和架构)
- [3.安装方法](README.md#3安装方法)
- [4.卸载方法](README.md#4卸载方法)
- [5.命令行参数](README.md#5命令行参数)
- [6.使用示例](README.md#6使用示例)
* * *

## 1.特点

- Cloudflare Tunnel 突破需要公网入口的限制 --- 传统的各协议服务端需要公网端口，本项目借用 Cloudflare Tunnel，使用内网穿透的办法.
- 应用场景广 --- 除传统的 VPS 外，还可以在各容器和游戏平台部署
- 无需额外优选 --- 因为国外的 VPS 一般线路较好，所以可以直连 Cloudflare Tunnel，使用 WS CDN 时无需额外优选，无需担心网络质量问题
- 轻量运行 --- 近乎 0 依赖，不需要处理证书

## 2.支持的操作系统和架构

| | 系统 | 架构 |
| -- | -- | -- | 
| 服务端 | CentOS,Debian,Ubuntu,OpenWRT | amd64 (x86_64),amd64 (x86_64),armv7 |
| 客户端 | CentOS,Debian,Ubuntu,Alpine | amd64 (x86_64),amd64 (x86_64),armv7 |

## 3.安装方法

### 服务端安装

#### 交互式安装：

```bash
bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/cfd_return/main/cfd_return.sh)
```

#### 快捷参数安装：

```
bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/cfd_return/main/cfd_return.sh) \
  -s \
  -p server-origin-port \
  -d your-domain.com \
  -w your-ws-path \
  -t 4 \
  -a your-cloudflare-auth
```

### 客户端安装

#### 交互式安装：

```
bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/cfd_return/main/cfd_return.sh)
```

#### 快捷参数安装：

```
bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/cfd_return/main/cfd_return.sh) \
  -c \
  -r remote-socks5-port \
  -d your-domain.com \
  -w your-ws-path
```

## 4.卸载方法

```
bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/cfd_return/main/cfd_return.sh) -u
```

## 5.命令行参数

| 参数 | 说明                    | 使用场景       |
| ---- | ----------------------- | -------------- |
| -h   | 显示帮助信息            | 服务端和客户端   |
| -u   | 卸载服务端和客户端      | 服务端和客户端   |
| -w   | WebSocket 路径          | 服务端和客户端 |
| -d   | Cloudflare Tunnel 域名  | 服务端和客户端 |
| -s   | 安装服务端              | 服务端         |
| -a   | Cloudflare Tunnel json 或 token 认证 | 服务端         |
| -t   | Cloudflared 优选 IP 列表 [4,6,d]，默认为双栈 d | 服务端 |
| -p   | 服务端端口              | 服务端         |
| -n   | 显示客户端安装命令      | 服务端         |
| -c   | 安装客户端              | 客户端         |
| -r   | 映射到服务端的 SOCKS5 端口  | 客户端         |

## 6.使用示例

### 服务端完整安装示例：

```
bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/cfd_return/main/cfd_return.sh) \
  -s \
  -p 20000 \
  -d cfd.example.com \
  -w 3b451552-e776-45c5-9b98-bde3ab99bf75 \
  -t 4 \
  -a eyJhIjoiOWN...
```

### 客户端完整安装示例：

```
bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/cfd_return/main/cfd_return.sh) \
  -c \
  -r 30000 \
  -d cfd.example.com \
  -w 3b451552-e776-45c5-9b98-bde3ab99bf75
```

### 查看客户端安装命令：

```
bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/cfd_return/main/cfd_return.sh) -n
```

### 卸载所有组件：

```
bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/cfd_return/main/cfd_return.sh) -u
```


## 10.鸣谢下列作者的文章和项目:
千歌 sing-box 模板: https://github.com/chika0801/sing-box-examples  
瞎折腾 sing-box 模板: https://t.me/ztvps/100


## 11.免责声明:
* 本程序仅供学习了解, 非盈利目的，请于下载后 24 小时内删除, 不得用作任何商业用途, 文字、数据及图片均有所属版权, 如转载须注明来源。
* 使用本程序必循遵守部署免责声明。使用本程序必循遵守部署服务器所在地、所在国家和用户所在国家的法律法规, 程序作者不对使用者任何不当行为负责。
